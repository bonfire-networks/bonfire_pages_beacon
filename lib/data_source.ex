defmodule Bonfire.Pages.Beacon.DataSource do
  @behaviour Beacon.DataSource.Behaviour

  import Bonfire.Pages.Beacon.Integration

  def live_data(_site, ["home"], _params), do: %{vals: ["first", "second", "third"]}

  def live_data(_site, ["blog", blog_slug], _params),
    do: %{blog_slug_uppercase: String.upcase(blog_slug)}

  def live_data(_, _, _), do: %{}
end
