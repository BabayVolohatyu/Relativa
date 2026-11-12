# Stateless architecture, explained for me (Lab 2)

Private notes. Plain language first, then the real code from this repo, then the real numbers.

---

## 1. What "stateless" means

A service is **stateless** when a request can be handled by **any copy** of the service and the answer is the same,
because the copy does not remember anything *between* requests in its own memory.

Analogy: a cashier with a sticky note.

- **Stateful cashier**: you tell cashier A "I'm customer 17, I already paid for the milk" and she writes it on a
  sticky note on her own desk. If your next question lands on cashier B, B has no idea who you are. The shop only
  works if you always go back to cashier A ("sticky sessions"), and if A goes home, the note is gone.
- **Stateless cashier**: every cashier looks in the **shop's shared ledger** (the database / Redis). Notes live
  there, not on desks. You can talk to any cashier, and if one goes home nothing is lost.

Why it matters for high load: to survive more traffic you add more copies behind a load balancer. That only works
if copies are interchangeable. Every private "sticky note" (a dictionary or cache inside the process) breaks it.

### Stateless does NOT mean "no data"

The system still has data: users, deals, graph, rate-limit counters. Stateless means **the service process does not
own that data**. The data lives in shared infrastructure (PostgreSQL, Redis, RabbitMQ) that every copy can reach.
A stateless service can be killed and restarted at any moment because the memory it loses was never important.

---

## 2. Was it stateless here before the lab?

**No. Mostly, but not fully.** The services were already *almost* stateless: business data was in PostgreSQL, JWT
tokens carry the user identity (no server-side session), and there is no file upload to local disk. That is why the
lab was possible with a small change set. But with **two copies** running I proved three real bugs, all caused by
"sticky notes" kept in process memory:

| # | Sticky note in memory | Symptom with 2 copies (measured BEFORE) | Measured AFTER |
|---|---|---|---|
| 1 | Auth: e-mail/support rate limiter counters (`MemoryEmailRateLimiter`) | Limit is 5 per hour per IP, **10** requests accepted (each copy counted its own 5) | **5** accepted, 5 rejected (429) |
| 2 | Graph: "ML recalculation already queued" cooldown (`IMemoryCache`) | The same job was queued **2** times (each copy had its own cooldown) | **1** job |
| 3 | Graph: SignalR groups (who is subscribed to which workspace) | A client connected to copy 1 received only **10 of 20** events published by copy 2; the rest were lost silently | **20 of 20** |

Raw proof: `before/` and `after/` folders next to this file.

---

## 3. Before vs. after in code

### Bug 1: rate limiter (Auth)

BEFORE: counter in a `ConcurrentDictionary` inside the process (`MemoryEmailRateLimiter`). Each copy has its own.

```csharp
// every instance has ITS OWN dictionary -> limit is effectively 5 x number_of_instances
builder.Services.AddSingleton<IEmailRateLimiter, MemoryEmailRateLimiter>();
```

AFTER: the counter lives in Redis. One shared counter, incremented atomically by a tiny Lua script, so two copies
cannot both read "4" and both write "5".

```csharp
// Authentication/.../Services/RedisEmailRateLimiter.cs
local count = redis.call('INCR', KEYS[1])
if count == 1 or redis.call('PTTL', KEYS[1]) < 0 then redis.call('PEXPIRE', KEYS[1], ARGV[1]) end
return count
```

```csharp
// Authentication/.../Program.cs  (Redis when configured, old in-memory only as a local fallback)
if (!string.IsNullOrWhiteSpace(redisConnection))
{
    builder.Services.AddSingleton<IConnectionMultiplexer>(_ => ConnectionMultiplexer.Connect(redisConnection));
    builder.Services.AddSingleton<IEmailRateLimiter, RedisEmailRateLimiter>();
}
```

### Bug 2: ML cooldown (Graph)

BEFORE: `IMemoryCache` is a dictionary inside this process.

```csharp
if (unscoredIds.Count > 0 && !cache.TryGetValue(cooldownKey, out _))
{
    cache.Set(cooldownKey, true, TimeSpan.FromMinutes(5));   // only THIS copy knows
    _ = mlRecalc.EnqueueAsync(unscoredIds, userId, workspaceId);
}
```

AFTER: `IDistributedCache`, backed by Redis in the containers.

```csharp
// WorkspaceDashboardService.EnqueueUnscoredDealsAsync (a small method of its own after the complexity refactor)
if (unscoredIds.Count == 0 || await cache.GetAsync(cooldownKey, ct) is not null)
    return;

await cache.SetAsync(cooldownKey, [1],
    new DistributedCacheEntryOptions { AbsoluteExpirationRelativeToNow = EnqueueCooldown }, ct);   // ALL copies see it
await EnsureDealAnalysisEntitiesAsync(unscoredIds, workspaceId, userId, ct);
_ = mlRecalc.EnqueueAsync(unscoredIds, userId, workspaceId);
```

(Honest caveat: get-then-set is not atomic, so two requests at the *same millisecond* can still both enqueue.
Making it a single `SET NX` would close that. Not needed for the lab, noted as a residual risk.)

### Bug 3: SignalR (Graph)

BEFORE: each copy keeps its own list of connections and groups.

```csharp
builder.Services.AddSignalR();        // groups live in this process only
```

AFTER: copies publish hub messages through Redis pub/sub, and every copy delivers to its own local clients.

```csharp
builder.Services.AddSignalR()
    .AddStackExchangeRedis(redisConnection!, o => o.Configuration.ChannelPrefix = RedisChannel.Literal("relativa-graph"));
```

### Bonus: seeing which copy answered

Every response now carries `X-Instance-ID: graph-1` or `graph-2` (and `auth-1`/`auth-2`). That is how I can *show*
that requests really go to different copies:

```
GET /api/v1/graph -> 200  X-Instance-ID=graph-1  nodes=183 edges=291
GET /api/v1/graph -> 200  X-Instance-ID=graph-2  nodes=183 edges=291   <- same data from another copy
```

### One more thing I found: the web client had a hidden "stickiness"

SignalR's default connection starts with an HTTP `negotiate` call, which stores connection state in ONE copy, and
then upgrades to WebSocket, which must reach that SAME copy. Through a round-robin balancer it does not:

- With the old client settings through nginx: only **2 of 10 connections succeeded**, 8 failed (`404` on the upgrade).
  (The first time I measured it, it was 0 of 10; the exact number depends on where the round-robin counter happens
  to be, but it is always mostly failures.)
  Proof: `after/signalr-negotiate-affinity-probe.txt`.
- Fix in `Client/src/api/graphHub.ts`: `skipNegotiation: true` + WebSockets only. Then any copy can accept it.
  Proof: `after/signalr-via-lb-skipnegotiate.txt` (20 of 20 events delivered through nginx).

This is the textbook "hidden affinity": nothing looks stateful in the code, but the protocol is.

---

## 4. Did it make it faster?

No measurable difference, and I should not pretend there is one. Full tables (with % change) are in
`k6/COMPARISON.md`. I ran each side twice:

| | 1 instance (pre) | 2 instances behind nginx (post) |
|---|---|---|
| requests in 2 minutes, run 1 | 3587 | 3424 |
| requests in 2 minutes, run 2 | 3664 | 3770 |
| avg latency, run 1 | 887 ms | 954 ms |
| avg latency, run 2 | 859 ms | 821 ms |
| p95 latency, run 1 | 1.06 s | 1.27 s |
| p95 latency, run 2 | 941 ms | 910 ms |
| failed requests | 0 | 0 |

Run 1 looked slightly worse after the change, run 2 slightly better. The same setup measured twice already differs by
up to 11% (before) and up to 29% on p95 (after), so noise is bigger than either difference. Neither direction is a result.

Why nothing changes: this test has a fixed number of virtual users and every request takes ~0.77 s even with nobody
else around, so one instance was not saturated; a second one has nothing to take over, and everything runs on one
laptop anyway. The lab's goal is not speed but **the ability to scale and to lose an instance safely**. Speed gains
are the topic of later labs. Where exactly the 0.77 s goes (ML round trip? database?) was not profiled in this lab.

What the lab did prove: killing a copy mid-traffic gave 0 failed requests out of 77, and data written through a
dead copy was readable from the restarted one (`after/restart-scenario.txt`).

---

## 5. One-sentence version for the defence

"Before, three pieces of state were hidden in process memory, so a second copy gave wrong answers (10 instead of 5
accepted requests, duplicate jobs, lost realtime events); now that state lives in Redis, any copy can serve any
request, and killing a copy loses nothing."
