using Relativa.Authentication.Application.Interfaces;
using StackExchange.Redis;

namespace Relativa.Authentication.Infrastructure.Services;

/// <summary>
/// Fixed-window rate limiter whose counters live in Redis, so every Auth instance shares the same
/// counter for a given key (unlike <see cref="MemoryEmailRateLimiter"/>, whose dictionary is per process).
/// Same semantics as the in-memory version: the window starts at the first consumed permit.
/// </summary>
/// <remarks>
/// INCR and PEXPIRE run inside one Lua script, i.e. atomically. A plain INCR followed by a separate
/// EXPIRE could be interrupted (instance killed in between) and leave a counter without TTL that would
/// block the key forever.
/// If Redis is unreachable the call throws (fail closed): these limits protect e-mail/SMS sending and
/// verification-code brute forcing, so silently disabling them during an outage would be worse than an error.
/// </remarks>
public sealed class RedisEmailRateLimiter(IConnectionMultiplexer redis) : IEmailRateLimiter
{
    private const string KeyPrefix = "relativa-auth:rate:";

    private const string ConsumeScript = """
        local count = redis.call('INCR', KEYS[1])
        if count == 1 or redis.call('PTTL', KEYS[1]) < 0 then
            redis.call('PEXPIRE', KEYS[1], ARGV[1])
        end
        return count
        """;

    public bool TryConsume(string key, int permitLimit, TimeSpan window)
    {
        var windowMs = Math.Max(1L, (long)window.TotalMilliseconds);
        var result = redis.GetDatabase().ScriptEvaluate(
            ConsumeScript,
            [(RedisKey)(KeyPrefix + key)],
            [(RedisValue)windowMs]);

        return (long)result <= permitLimit;
    }
}
