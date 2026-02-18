using MilkWalla.Blazor.Shared.Notifications;

namespace MilkWalla.Blazor.Infrastructure.Notifications;

public interface INotificationPublisher
{
    Task PublishAsync(INotificationMessage notification);
}