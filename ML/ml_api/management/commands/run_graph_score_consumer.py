import json
import logging
import time

import pika
from django.conf import settings
from django.core.management.base import BaseCommand

from ml_api.apps import MlApiConfig
from ml_api.recalculate_service import (
    BATCH_TIMEOUT_SECONDS,
    normalize_entity_ids,
    _check_deadline,
    _ensure_deal_analysis_entities,
    _load_schema_config,
)
from ml_api.views import score_prepared_deals

logger = logging.getLogger(__name__)

EXCHANGE_NAME = "relativa.graph_ml"
EXCHANGE_TYPE = "topic"
QUEUE_NAME = "ml.graph.score_request.v1"
ROUTING_KEY = "graph.score.request"
DLX_NAME = "relativa.graph_ml.dlx"
DLQ_NAME = "ml.graph.score_request.v1.failed"


class Command(BaseCommand):
    help = "Run RabbitMQ RPC consumer for Graph→ML scoring requests."

    def handle(self, *args, **options):
        logging.basicConfig(level=logging.INFO)
        credentials = pika.PlainCredentials(settings.RABBITMQ_USER, settings.RABBITMQ_PASSWORD)
        parameters = pika.ConnectionParameters(
            host=settings.RABBITMQ_HOST,
            port=settings.RABBITMQ_PORT,
            credentials=credentials,
            heartbeat=600,
        )
        conn = pika.BlockingConnection(parameters)
        channel = conn.channel()

        channel.exchange_declare(exchange=EXCHANGE_NAME, exchange_type=EXCHANGE_TYPE, durable=True)
        channel.exchange_declare(exchange=DLX_NAME, exchange_type="fanout", durable=True)
        channel.queue_declare(queue=DLQ_NAME, durable=True)
        channel.queue_bind(exchange=DLX_NAME, queue=DLQ_NAME, routing_key="")
        channel.queue_declare(
            queue=QUEUE_NAME,
            durable=True,
            arguments={"x-dead-letter-exchange": DLX_NAME},
        )
        channel.queue_bind(exchange=EXCHANGE_NAME, queue=QUEUE_NAME, routing_key=ROUTING_KEY)
        channel.basic_qos(prefetch_count=4)

        def on_message(ch, method_frame, properties, body):
            reply_to = properties.reply_to
            correlation_id = properties.correlation_id

            def reply(payload: dict):
                if not reply_to:
                    return
                ch.basic_publish(
                    exchange="",
                    routing_key=reply_to,
                    body=json.dumps(payload).encode("utf-8"),
                    properties=pika.BasicProperties(correlation_id=correlation_id),
                )

            try:
                data = json.loads(body.decode("utf-8"))
            except json.JSONDecodeError:
                logger.exception("Malformed graph score RPC request")
                reply({"scores": [], "errorMessage": "Malformed JSON request."})
                ch.basic_ack(delivery_tag=method_frame.delivery_tag)
                return

            # C# sends camelCase; support both
            raw_ids = data.get("entityIds") or data.get("entity_ids")
            try:
                entity_ids = normalize_entity_ids(raw_ids)
            except ValueError as exc:
                logger.warning("Invalid entity_ids in graph score RPC: %s", exc)
                reply({"scores": [], "errorMessage": str(exc)})
                ch.basic_ack(delivery_tag=method_frame.delivery_tag)
                return

            try:
                scores = _run_scoring(entity_ids)
                reply({"scores": scores, "errorMessage": None})
            except Exception:
                logger.exception("Graph score RPC scoring failed for entity_ids=%s", entity_ids)
                reply({"scores": [], "errorMessage": "Internal scoring error."})

            ch.basic_ack(delivery_tag=method_frame.delivery_tag)

        channel.basic_consume(queue=QUEUE_NAME, on_message_callback=on_message, auto_ack=False)
        self.stdout.write(self.style.SUCCESS(f"ML graph score RPC consumer listening on {QUEUE_NAME}."))
        channel.start_consuming()


def _run_scoring(entity_ids: list[int]) -> list[dict]:
    """Run the same batch scoring pipeline as the score_batch HTTP view."""
    if not entity_ids:
        return []

    if (MlApiConfig.churn_model is None) or (MlApiConfig.closure_model is None):
        return [
            {"entityId": eid, "closureScore": None, "churnScore": None, "unavailableReason": "ML models not loaded."}
            for eid in entity_ids
        ]

    started = time.perf_counter()
    deadline = started + BATCH_TIMEOUT_SECONDS

    config = _load_schema_config()
    _check_deadline(deadline)
    _ensure_deal_analysis_entities(entity_ids, config, deadline)
    _check_deadline(deadline)

    response_payload = score_prepared_deals(entity_ids, deadline, config)

    # Serialize to camelCase to match C# MlScoreRpcItemV1
    return [
        {
            "entityId": item["entity_id"],
            "closureScore": item["closure_score"],
            "churnScore": item["churn_score"],
            "unavailableReason": item["unavailable_reason"],
        }
        for item in response_payload
    ]
