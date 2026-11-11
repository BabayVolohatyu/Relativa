using StackExchange.Redis;

namespace Relativa.Graph.Graph;

/// <summary>
/// Lab 4: one shared ConnectionMultiplexer for IDistributedCache and the graph cache (SCAN/DEL).
/// Tuned to fail fast: when Redis is down a request must not queue behind the dead connection
/// (default backlog would hold each command until its timeout), it must go straight to PostgreSQL.
/// The multiplexer reconnects on its own, so the cache comes back by itself when Redis is started again.
/// </summary>
public static class RedisMultiplexerFactory
{
    public static IConnectionMultiplexer Create(string connectionString)
    {
        var options = ConfigurationOptions.Parse(connectionString);
        options.AbortOnConnectFail = false;
        options.BacklogPolicy = BacklogPolicy.FailFast;
        options.AsyncTimeout = 1000;
        options.SyncTimeout = 1000;
        options.ConnectRetry = 1;
        return ConnectionMultiplexer.Connect(options);
    }
}
