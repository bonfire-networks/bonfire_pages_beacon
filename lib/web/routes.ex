defmodule Bonfire.Pages.Beacon.Web.Routes do
  @behaviour Bonfire.UI.Common.RoutesModule

  defmacro __using__(_) do
    quote do
      use Beacon.Router
      use Beacon.LiveAdmin.Router

      pipeline :beacon_api do
        plug :accepts, ["json"]
      end

      pipeline :beacon_admin do
        plug Beacon.LiveAdmin.Plug
      end

      # pages anyone can view
      scope "/site/" do
        pipe_through(:browser)

        beacon_site("/", site: Bonfire.Pages.Beacon.Integration.default_site())

        # live_session :beacon,
        #   session: %{"beacon_site" => Bonfire.Pages.Beacon.Integration.default_site()} do
        #   live("*path", BeaconWeb.PageLive, :path)
        # end
      end

      # *only* guests can view
      scope "/pages/" do
        pipe_through(:browser)
        pipe_through(:guest_only)
      end

      # you need an account to view
      scope "/pages/" do
        pipe_through(:browser)
        pipe_through(:account_required)
      end

      # anything you need to view as a user
      scope "/pages/" do
        pipe_through(:browser)
        pipe_through(:user_required)
      end

      # only admins can view
      scope "/page_management" do
        pipe_through(:browser)
        pipe_through(:admin_required)
        pipe_through(:beacon_admin)

        beacon_live_admin("/")
        # BeaconWeb.PageManagement.routes()
      end

      # API only admins can view
      scope "/page_management/api" do
        pipe_through(:beacon_api)
        pipe_through(:admin_required)

        beacon_api("/")
        # BeaconWeb.PageManagementApi.routes()
      end
    end
  end
end
