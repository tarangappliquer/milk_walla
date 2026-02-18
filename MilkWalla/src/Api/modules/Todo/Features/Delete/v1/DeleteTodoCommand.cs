using MediatR;

namespace MilkWalla.WebApi.Todo.Features.Delete.v1;

public sealed record DeleteTodoCommand(
    Guid Id) : IRequest;



