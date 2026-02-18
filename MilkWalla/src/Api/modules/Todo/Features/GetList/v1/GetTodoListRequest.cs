using FSH.Framework.Core.Paging;
using MediatR;

namespace MilkWalla.WebApi.Todo.Features.GetList.v1;

public record GetTodoListRequest(PaginationFilter Filter) : IRequest<PagedList<TodoDto>>;
