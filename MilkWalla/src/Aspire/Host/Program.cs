var builder = DistributedApplication.CreateBuilder(args);

var grafana = builder.AddContainer("grafana", "grafana/grafana")
    .WithBindMount("../../../compose/grafana/config", "/etc/grafana", isReadOnly: true)
    .WithBindMount("../../../compose/grafana/dashboards", "/var/lib/grafana/dashboards", isReadOnly: true)
    .WithHttpEndpoint(port: 3000, targetPort: 3000, name: "http");

var prometheus = builder.AddContainer("prometheus", "prom/prometheus")
    .WithBindMount("../../../compose/prometheus", "/etc/prometheus", isReadOnly: true)
    .WithHttpEndpoint(port: 9090, targetPort: 9090);

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

builder.AddProject<Projects.Client>("blazor");

using var app = builder.Build();

await app.RunAsync();
