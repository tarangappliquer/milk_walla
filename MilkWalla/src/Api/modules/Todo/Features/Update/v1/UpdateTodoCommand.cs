using MediatR;

namespace MilkWalla.WebApi.Todo.Features.Update.v1;

public sealed record UpdateTodoCommand(
    Guid Id,
    string? Title,
    string? Note = null) : IRequest<UpdateTodoResponse>;



