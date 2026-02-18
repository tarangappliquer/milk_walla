using FSH.Framework.Core.Paging;
using MediatR;
using MilkWalla.WebApi.Catalog.Application.Brands.Get.v1;

namespace MilkWalla.WebApi.Catalog.Application.Brands.Search.v1;

public class SearchBrandsCommand : PaginationFilter, IRequest<PagedList<BrandResponse>>
{
    public string? Name { get; set; }
    public string? Description { get; set; }
}
