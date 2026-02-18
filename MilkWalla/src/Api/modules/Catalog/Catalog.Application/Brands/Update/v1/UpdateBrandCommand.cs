using MediatR;

namespace MilkWalla.WebApi.Catalog.Application.Brands.Update.v1;

public sealed record UpdateBrandCommand(
    Guid Id,
    string? Name,
    string? Description = null) : IRequest<UpdateBrandResponse>;
