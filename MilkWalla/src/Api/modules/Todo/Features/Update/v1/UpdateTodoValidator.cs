using FluentValidation;
using MilkWalla.WebApi.Todo.Persistence;

namespace MilkWalla.WebApi.Todo.Features.Update.v1;

public class UpdateTodoValidator : AbstractValidator<UpdateTodoCommand>
{
    public UpdateTodoValidator(TodoDbContext context)
    {
        RuleFor(p => p.Title).NotEmpty();
        RuleFor(p => p.Note).NotEmpty();
    }
}
