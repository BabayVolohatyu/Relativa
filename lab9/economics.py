"""Financial quality ledger from a SonarQube Cloud measures file.

Reads sqale_index and ncloc from the measures array. Rates come only from
the environment: HOURLY_RATE, OVERLOAD_COEFF, DISCOUNT_RATE.
"""

import argparse
import json
import os
import sys
from decimal import Decimal, ROUND_HALF_UP
from pathlib import Path


MONTHS = 6
CENTS = Decimal("0.01")
FACTOR = Decimal("0.000001")


def fail(message: str) -> None:
    print(message, file=sys.stderr)
    sys.exit(1)


def require_decimal(name: str) -> Decimal:
    raw = os.environ.get(name)
    if raw is None or raw.strip() == "":
        fail(f"Missing environment variable {name}")
    try:
        return Decimal(raw.strip())
    except Exception:
        fail(f"Environment variable {name} is not a decimal: {raw}")


def money(value: Decimal) -> str:
    return f"{value.quantize(CENTS, rounding=ROUND_HALF_UP)}"


def factor(value: Decimal) -> str:
    return f"{value.quantize(FACTOR, rounding=ROUND_HALF_UP)}"


def measure(measures: list, key: str) -> Decimal:
    for item in measures:
        if item.get("metric") == key:
            raw = item.get("value")
            if raw is None or str(raw).strip() == "":
                fail(f"Metric {key} has no value")
            try:
                return Decimal(str(raw))
            except Exception:
                fail(f"Metric {key} is not a decimal: {raw}")
    fail(f"Metric {key} is missing from the measures array")


def load_report(path: Path) -> tuple[str, Decimal, Decimal]:
    try:
        payload = json.loads(path.read_text(encoding="utf-8"))
    except FileNotFoundError:
        fail(f"Input file not found: {path}")
    except json.JSONDecodeError as error:
        fail(f"Input file is not JSON: {error}")

    component = payload.get("component")
    if not isinstance(component, dict):
        fail("JSON has no component object")
    key = component.get("key")
    if not key:
        fail("JSON component has no key")
    measures = component.get("measures")
    if not isinstance(measures, list):
        fail("JSON component has no measures array")

    return str(key), measure(measures, "sqale_index"), measure(measures, "ncloc")


def build_ledger(
    project_key: str,
    sqale_index: Decimal,
    ncloc: Decimal,
    hourly_rate: Decimal,
    overload: Decimal,
    discount_rate: Decimal,
) -> tuple[str, str, int | None]:
    principal = (sqale_index / Decimal(60)) * hourly_rate * overload
    cost_of_delay = (ncloc / Decimal(100)) * hourly_rate * overload

    rows: list[tuple[int, Decimal, Decimal, Decimal]] = []
    cumulative = -principal
    payback: int | None = None
    for month in range(1, MONTHS + 1):
        discount = (Decimal(1) + discount_rate) ** (-month)
        profit = cost_of_delay * discount
        cumulative += profit
        if payback is None and cumulative > 0:
            payback = month
        rows.append((month, discount, profit, cumulative))

    if payback is None:
        verdict = (
            "Точка виходу в нуль (Payback Period) на дистанції 6 місяців не настає."
        )
        gate = "FAIL"
        warning = (
            "Архітектурне попередження: борг занадто великий, "
            "щоб інвестиція вийшла в плюс за 6 місяців."
        )
    else:
        verdict = (
            f"Точка виходу в нуль (Payback Period) настає на місяці {payback}."
        )
        gate = "PASS"
        warning = ""

    lines = [
        "# SOFTWARE ECONOMICS & FINANCIAL QUALITY LEDGER",
        "",
        "## 1. Вхідні параметри аудиту (System Baseline)",
        "",
        f"- Назва аналізованого проєкту (Key): {project_key}",
        f"- Масштаб системи (NCLOC): {ncloc}",
        f"- Початковий технічний борг (SQALE Index): {sqale_index} хвилин",
        "",
        "## 2. Капіталізація інвестиційних маркерів",
        "",
        f"- Погодинна ставка (HOURLY_RATE): {hourly_rate} $",
        f"- Коефіцієнт накладних витрат (OVERLOAD_COEFF): {overload}",
        f"- Місячний коефіцієнт дисконтування (DISCOUNT_RATE): {discount_rate}",
        f"- Тіло боргу (вартість рефакторингу): {money(principal)} $",
        f"- Щомісячні збитки від бездіяльності (Cost of Delay): {money(cost_of_delay)} $",
        "",
        "## 3. Динаміка окупності інвестицій у часі (6 ітерацій розробки)",
        "",
        "| Місяць | Коефіцієнт дисконтування | Щомісячний прибуток, $ | Кумулятивний NPV, $ |",
        "|---:|---:|---:|---:|",
    ]
    for month, discount, profit, cumulative_npv in rows:
        lines.append(
            f"| {month} | {factor(discount)} | {money(profit)} | {money(cumulative_npv)} |"
        )
    lines.extend(
        [
            "",
            "## 4. Фінальний інженерно-економічний вердикт",
            "",
            verdict,
            "",
            "## 5. СТАТУС ВОРІТ ЯКОСТІ (Quality Gate)",
            "",
            gate,
        ]
    )
    if warning:
        lines.extend(["", warning])
    lines.append("")
    return "\n".join(lines), gate, payback


def main() -> None:
    parser = argparse.ArgumentParser(description="Build a financial quality ledger from report.json")
    parser.add_argument("--input", required=True, help="SonarQube Cloud measures JSON")
    parser.add_argument("--output", required=True, help="Markdown ledger path")
    args = parser.parse_args()

    hourly_rate = require_decimal("HOURLY_RATE")
    overload = require_decimal("OVERLOAD_COEFF")
    discount_rate = require_decimal("DISCOUNT_RATE")

    input_path = Path(args.input)
    output_path = Path(args.output)
    project_key, sqale_index, ncloc = load_report(input_path)
    ledger, gate, payback = build_ledger(
        project_key,
        sqale_index,
        ncloc,
        hourly_rate,
        overload,
        discount_rate,
    )
    output_path.parent.mkdir(parents=True, exist_ok=True)
    output_path.write_text(ledger, encoding="utf-8")
    print(f"Wrote {output_path.as_posix()}")
    print(f"Quality gate: {gate}")
    if payback is None:
        print("Payback: none within 6 months")
    else:
        print(f"Payback month: {payback}")


if __name__ == "__main__":
    main()
