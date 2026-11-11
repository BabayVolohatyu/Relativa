import * as signalR from '@microsoft/signalr';
import { useAuthStore } from '@/stores/auth';

function hubUrl(): string {
  const base = (import.meta.env.VITE_GATEWAY_URL ?? 'http://localhost:8080').replace(/\/$/, '');
  return `${base}/graph/hubs/graph`;
}

export function buildGraphHubConnection(): signalR.HubConnection {
  const auth = useAuthStore();
  return new signalR.HubConnectionBuilder()
    .withUrl(hubUrl(), {
      accessTokenFactory: () => auth.accessToken ?? '',
      // Lab 2 (stateless Graph): the HTTP "negotiate" step creates connection state in the memory of ONE
      // Graph instance, and the following WebSocket upgrade must reach that same instance. Behind a
      // non-sticky load balancer it does not (404 on upgrade). Skipping negotiation and going straight to
      // WebSockets removes that hidden affinity, so any instance can accept the connection.
      skipNegotiation: true,
      transport: signalR.HttpTransportType.WebSockets,
    })
    .withAutomaticReconnect()
    .configureLogging(signalR.LogLevel.Warning)
    .build();
}
