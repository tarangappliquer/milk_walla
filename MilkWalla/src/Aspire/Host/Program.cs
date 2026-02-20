var builder = DistributedApplication.CreateBuilder(args);

var useWithContainers = builder.Configuration["UseWithContainer"] == bool.TrueString;
var useRedis = builder.Configuration["UseRedis"] == bool.TrueString;

var isApiServerAdded = false;

if (useWithContainers)
{
    builder.AddContainer("grafana", "grafana/grafana")
        .WithBindMount("../../../compose/grafana/config", "/etc/grafana", isReadOnly: true)
        .WithBindMount("../../../compose/grafana/dashboards", "/var/lib/grafana/dashboards", isReadOnly: true)
        .WithHttpEndpoint(port: 3000, targetPort: 3000, name: "http");

    builder.AddContainer("prometheus", "prom/prometheus")
        .WithBindMount("../../../compose/prometheus", "/etc/prometheus", isReadOnly: true)
        .WithHttpEndpoint(port: 9090, targetPort: 9090);

    if (useRedis)
    {
        var redisPassword = "YourSecurePassword123";

        var redis = builder.AddContainer("redis-container", "redis:latest")
            .WithVolume("redis_container_data", "/data")
            .WithArgs("--requirepass", redisPassword)
            .WithEndpoint(name: "redis-endpoint", port: 6379, targetPort: 6379);

        builder.AddContainer("redis-gui", "rediscommander/redis-commander:latest")
            .WaitFor(redis)
            .WithEnvironment("REDIS_HOSTS", $"local:{redis.Resource.Name}:6379:0:{redisPassword}")

            .WithEnvironment("AUTH_ALLOWED", "true")
            .WithEnvironment("HTTP_USER", "admin")
            .WithEnvironment("HTTP_PASSWORD", "ComplexGuiPassword!")

            .WithEnvironment("ADMIN_USER", "admin")
            .WithEnvironment("ADMIN_PASSWORD", "ComplexGuiPassword!")
            .WithHttpEndpoint(name: "gui-link", port: 8081, targetPort: 8081);

        builder.AddProject<Projects.Server>("webapi")
            .WaitFor(redis)
            .WithEnvironment("CacheOptions__Redis", () =>
            {
                // This picks the right address based on whether the API is containerized or not
                var endpoint = redis.GetEndpoint("redis-endpoint");
                return $"{endpoint.Host}:{endpoint.Port},password={redisPassword},abortConnect=false";
            });

        isApiServerAdded = true;
    }

}

if (!isApiServerAdded)
{
    builder.AddProject<Projects.Server>("webapi");
}

builder.AddProject<Projects.Client>("blazor");

using var app = builder.Build();

await app.RunAsync();
