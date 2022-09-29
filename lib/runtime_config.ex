defmodule Bonfire.Pages.Beacon.RuntimeConfig do
  use Bonfire.Common.Localise

  def config_module, do: true

  @doc """
  NOTE: you can override this default config in your app's `runtime.exs`, by placing similarly-named config keys below the `Bonfire.Common.Config.LoadExtensionsConfig.load_configs()` line
  """
  def config do
    import Config

    config :bonfire_pages_beacon,
      disabled: false

    config :beacon,
      data_source: Bonfire.Pages.Beacon.DataSource,
      css_path: "/assets/bonfire_basic.css",
      # TODO: support using the non-live JS when serving cached static pages
      js_path: "/assets/bonfire_live.js"
  end
end
