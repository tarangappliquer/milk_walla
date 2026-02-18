using MediatR;

namespace MilkWalla.WebApi.Catalog.Application.Products.Delete.v1;

public sealed record DeleteProductCommand(
    Guid Id) : IRequest;
