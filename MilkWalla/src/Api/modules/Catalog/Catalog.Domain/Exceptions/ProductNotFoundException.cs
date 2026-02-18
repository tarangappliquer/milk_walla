using FSH.Framework.Core.Exceptions;

namespace MilkWalla.WebApi.Catalog.Domain.Exceptions;

public sealed class ProductNotFoundException : NotFoundException
{
    public ProductNotFoundException(Guid id)
        : base($"product with id {id} not found")
    {
    }
}
