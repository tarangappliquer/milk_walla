using MediatR;

namespace MilkWalla.WebApi.Catalog.Application.Brands.Delete.v1;

public sealed record DeleteBrandCommand(
    Guid Id) : IRequest;
