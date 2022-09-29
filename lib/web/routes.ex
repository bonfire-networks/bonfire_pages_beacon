defmodule Bonfire.Pages.Beacon.Web.Routes do
  defmacro __using__(_) do
    quote do
      pipeline :beacon do
        plug(BeaconWeb.Plug)
      end

      # pages anyone can view
      scope "/site/" do
        pipe_through(:browser)
        pipe_through(:beacon)

        # live "/", HomeLive

        live_session :beacon,
          session: %{"beacon_site" => Bonfire.Pages.Beacon.Integration.default_site()} do
          live("*path", BeaconWeb.PageLive, :path)
        end
      end

      # pages only guests can view
      scope "/pages/" do
        pipe_through(:browser)
        pipe_through(:beacon)
        pipe_through(:guest_only)
      end

      # pages you need an account to view
      scope "/pages/" do
        pipe_through(:browser)
        pipe_through(:beacon)
        pipe_through(:account_required)
      end

      # pages you need to view as a user
      scope "/pages/" do
        pipe_through(:browser)
        pipe_through(:beacon)
        pipe_through(:user_required)
      end

      require BeaconWeb.PageManagement
      require BeaconWeb.PageManagementApi

      # pages only admins can view
      scope "/page_management", BeaconWeb.PageManagement do
        pipe_through(:browser)
        pipe_through(:beacon)
        pipe_through(:admin_required)

        BeaconWeb.PageManagement.routes()
      end

      # API only admins can view
      scope "/page_management/api", BeaconWeb.PageManagementApi do
        pipe_through(:browser)
        pipe_through(:beacon)
        pipe_through(:admin_required)

        BeaconWeb.PageManagementApi.routes()
      end
    end
  end
end
