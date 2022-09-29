defmodule Bonfire.Pages.Beacon.Web.Helpers do
  import Phoenix.Component

  @doc """
    Usage:
    <.dynamic component={{Heroicons, :thumbs_up}} class="h-5 w-5" />
  """
  attr(:component, :any, required: true)

  def dynamic(%{component: {mod, func}} = assigns) do
    rest = assigns_to_attributes(assigns, [:component])
    env = {__ENV__.module, __ENV__.function, __ENV__.file, __ENV__.line}
    Phoenix.LiveView.HTMLEngine.component(Function.capture(mod, func, 1), rest, env)
  end

  def dynamic(%{component: mod} = assigns),
    do: dynamic(Map.merge(assigns, %{component: {mod, :render}, __context__: %{}}))
end
