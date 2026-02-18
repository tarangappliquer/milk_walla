using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Web;

namespace MilkWalla.Blazor.Client.Components.ThemeManager;

public partial class ThemeButton
{
    [Parameter]
    public EventCallback<MouseEventArgs> OnClick { get; set; }
}
