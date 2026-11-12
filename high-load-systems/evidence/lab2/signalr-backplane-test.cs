#:package Microsoft.AspNetCore.SignalR.Client@10.0.*
#:property PublishAot=false
#:property JsonSerializerIsReflectionEnabledByDefault=true
#:property NoWarn=NU1903;IL2026;IL3050
// Lab 2 - SignalR cross-instance delivery test (file-based .NET app, no project needed).
//
// Question answered: "If a browser is connected to Graph instance A, does it still receive an event
// that was consumed from RabbitMQ by Graph instance B?"
//
// How it works
//   1. Connect ONE SignalR client directly to instance 1 (WebSockets, skipNegotiation) and join group workspace-<id>.
//   2. Publish N "ml.recalculate.progress" domain events to RabbitMQ (through the management HTTP API).
//      Both Graph instances consume the SAME queue (competing consumers), so each event is handled by
//      exactly one instance - roughly half land on instance 1, half on instance 2.
//   3. The handling instance calls hubContext.Clients.Group("workspace-<id>").SendAsync(...).
//        * without a backplane  -> only reaches clients connected to THAT instance  (~N/2 delivered)
//        * with Redis backplane -> reaches clients on every instance                (N delivered)
//
// Usage (from repo root):
//   dotnet run high-load-systems/evidence/lab2/signalr-backplane-test.cs -- [hubUrl] [events] [workspaceId]
//   defaults: http://localhost:8083/hubs/graph  20  1

using System.Net.Http.Headers;
using System.Text;
using System.Text.Json;
using Microsoft.AspNetCore.Http.Connections;
using Microsoft.AspNetCore.SignalR.Client;

var hubUrl = args.Length > 0 ? args[0] : "http://localhost:8083/hubs/graph";
var total = args.Length > 1 ? int.Parse(args[1]) : 20;
var workspaceId = args.Length > 2 ? int.Parse(args[2]) : 1;

const string mgmt = "http://localhost:15672";
const string mgmtUser = "relativa";
const string mgmtPass = "relativa";

// Optional 4th argument "negotiate": affinity probe instead of the delivery test.
// Opens 10 connections the way the Vue client does (HTTP negotiate first, then WebSocket upgrade) and counts how
// many succeed. Through a round-robin balancer the negotiate request and the WebSocket upgrade can land on
// DIFFERENT instances; the connection state created by negotiate lives in the memory of the first one.
if (args.Length > 3 && args[3] == "negotiate")
{
    int ok = 0, failed = 0;
    for (var i = 1; i <= 10; i++)
    {
        var probe = new HubConnectionBuilder().WithUrl(hubUrl, o => o.Transports = HttpTransportType.WebSockets).Build();
        try { await probe.StartAsync(); ok++; await probe.StopAsync(); }
        catch (Exception ex) { failed++; Console.WriteLine($"  attempt {i}: {ex.GetType().Name}: {ex.Message}"); }
        await probe.DisposeAsync();
    }
    Console.WriteLine($"RESULT negotiate-probe hub={hubUrl} connected={ok} failed={failed}");
    return;
}

var received = 0;
var connection = new HubConnectionBuilder()
    .WithUrl(hubUrl, o =>
    {
        // skipNegotiation + WebSockets: no per-instance negotiate state, so this test does not depend on affinity.
        o.SkipNegotiation = true;
        o.Transports = HttpTransportType.WebSockets;
    })
    .Build();

connection.On<JsonElement>("ml.recalculate.progress.v1", _ => Interlocked.Increment(ref received));

await connection.StartAsync();
await connection.InvokeAsync("JoinWorkspace", workspaceId);
Console.WriteLine($"Client connected to {hubUrl} and joined workspace-{workspaceId}");

using var http = new HttpClient();
http.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue(
    "Basic", Convert.ToBase64String(Encoding.UTF8.GetBytes($"{mgmtUser}:{mgmtPass}")));

for (var i = 1; i <= total; i++)
{
    var jobId = Guid.NewGuid();
    var payload = new
    {
        jobId,
        workspaceId,
        status = "running",
        processedCount = i,
        totalCount = total,
        updatedAtUtc = DateTimeOffset.UtcNow,
        message = "lab2-signalr-test",
    };
    var envelope = new
    {
        schemaVersion = 1,
        messageId = Guid.NewGuid(),
        correlationId = jobId,
        sagaInstanceId = (Guid?)null,
        causationId = (Guid?)null,
        occurredAtUtc = DateTimeOffset.UtcNow,
        sourceService = "lab2-test",
        payloadTypeName = "relativa.domain.ml.recalculate_progress.v1",
        payloadJson = JsonSerializer.Serialize(payload),
    };
    var publish = new
    {
        properties = new { },
        routing_key = "ml.recalculate.progress",
        payload = JsonSerializer.Serialize(envelope),
        payload_encoding = "string",
    };
    var resp = await http.PostAsync(
        $"{mgmt}/api/exchanges/%2F/relativa.domain/publish",
        new StringContent(JsonSerializer.Serialize(publish), Encoding.UTF8, "application/json"));
    resp.EnsureSuccessStatusCode();
}

await Task.Delay(TimeSpan.FromSeconds(6)); // let both consumers drain the queue
Console.WriteLine($"RESULT hub={hubUrl} published={total} delivered_to_client={received} lost={total - received}");
await connection.StopAsync();
