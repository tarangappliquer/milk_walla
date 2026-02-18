using MilkWalla.Blazor.Shared.Notifications;

namespace MilkWalla.Blazor.Infrastructure.Notifications;

public record ConnectionStateChanged(ConnectionState State, string? Message) : INotificationMessage;