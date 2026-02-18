using FSH.Framework.Core.Persistence;
using MediatR;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using MilkWalla.WebApi.Catalog.Domain;
using MilkWalla.WebApi.Catalog.Domain.Exceptions;

namespace MilkWalla.WebApi.Catalog.Application.Products.Update.v1;

public sealed class UpdateProductHandler(
    ILogger<UpdateProductHandler> logger,
    [FromKeyedServices("catalog:products")] IRepository<Product> repository)
    : IRequestHandler<UpdateProductCommand, UpdateProductResponse>
{
    public async Task<UpdateProductResponse> Handle(UpdateProductCommand request, CancellationToken cancellationToken)
    {
        ArgumentNullException.ThrowIfNull(request);
        var product = await repository.GetByIdAsync(request.Id, cancellationToken);
        _ = product ?? throw new ProductNotFoundException(request.Id);
        var updatedProduct = product.Update(request.Name, request.Description, request.Price, request.BrandId);
        await repository.UpdateAsync(updatedProduct, cancellationToken);
        logger.LogInformation("product with id : {ProductId} updated.", product.Id);
        return new UpdateProductResponse(product.Id);
    }
}
