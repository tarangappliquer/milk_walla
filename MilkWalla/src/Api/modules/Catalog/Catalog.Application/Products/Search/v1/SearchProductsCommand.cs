using FSH.Framework.Core.Paging;
using MediatR;
using MilkWalla.WebApi.Catalog.Application.Products.Get.v1;

namespace MilkWalla.WebApi.Catalog.Application.Products.Search.v1;

public class SearchProductsCommand : PaginationFilter, IRequest<PagedList<ProductResponse>>
{
    public Guid? BrandId { get; set; }
    public decimal? MinimumRate { get; set; }
    public decimal? MaximumRate { get; set; }
}
