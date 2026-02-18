using FSH.Framework.Core.Domain.Events;

namespace MilkWalla.WebApi.Catalog.Domain.Events;

public sealed record BrandCreated : DomainEvent
{
    public Brand? Brand { get; set; }
}
