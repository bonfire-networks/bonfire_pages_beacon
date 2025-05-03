defmodule Bonfire.Pages.Beacon.Integration do
  use Bonfire.Common.Config
  alias Bonfire.Common.Utils
  import Untangle

  def default_site, do: :instance_site
  # def repo, do: Config.repo()
end
