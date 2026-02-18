using MediatR;
using Microsoft.Extensions.Logging;
using MilkWalla.WebApi.Catalog.Domain.Events;

namespace MilkWalla.WebApi.Catalog.Application.Brands.EventHandlers;

public class BrandCreatedEventHandler(ILogger<BrandCreatedEventHandler> logger) : INotificationHandler<BrandCreated>
{
    public async Task Handle(BrandCreated notification,
        CancellationToken cancellationToken)
    {
        logger.LogInformation("handling brand created domain event..");
        await Task.FromResult(notification);
        logger.LogInformation("finished handling brand created domain event..");
    }
}
