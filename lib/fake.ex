defmodule Bonfire.Pages.Beacon.Fake do
  import Bonfire.Pages.Beacon.Integration

  alias Beacon.Components
  alias Beacon.Pages
  alias Beacon.Layouts
  alias Beacon.Stylesheets

  def examples() do
    Stylesheets.create_stylesheet!(%{
      site: default_site(),
      name: "sample_stylesheet",
      content: "body { font-size: 1.2rem; }"
    })

    Beacon.Components.create_component!(%{
      site: default_site(),
      name: "surfaceful",
      body: """
        <Surface.Components.Dynamic.LiveComponent module={@component} id={Pointers.ULID.generate()} />
      """
    })

    Beacon.Components.create_component!(%{
      site: default_site(),
      name: "surfaceless",
      body: """
        <Surface.Components.Dynamic.Component module={@component} />
      """
    })

    Beacon.Components.create_component!(%{
      site: default_site(),
      name: "stateful",
      body: """
        <%= live_component(%{module: @component, id: Pointers.ULID.generate(), __context__: %{}}) %>
      """
    })

    Beacon.Components.create_component!(%{
      site: default_site(),
      name: "stateless",
      body: """
        <Bonfire.Pages.Beacon.Web.Helpers.dynamic component={@component} />
      """
    })

    Beacon.Components.create_component!(%{
      site: default_site(),
      name: "sample_component",
      body: """
      <li>
        <%= @val %>
      </li>
      """
    })

    %{id: layout_id} =
      Beacon.Layouts.create_layout!(%{
        site: default_site(),
        title: "Page with default styles",
        meta_tags: %{"foo" => "bar"},
        stylesheet_urls: [Application.get_env(:beacon, :css_path, "/assets/app.css")],
        body: """
        <header>
          Bonfire Page
        </header>

        <%= @inner_content %>

        <footer>
          <a href="/">Home</a>
        </footer>
        """
      })

    %{id: page_id} =
      Pages.create_page!(%{
        path: "home",
        site: default_site(),
        layout_id: layout_id,
        template: """
        <main>
          <h2>Some Values:</h2>
          <ul>
            <%= for val <- @beacon_live_data[:vals] do %>
              <%= my_component("sample_component", val: val) %>
            <% end %>
          </ul>
          <.form let={f} for={:greeting} phx-submit="hello">
            Name: <%= text_input f, :name %> <%= submit "Hello" %>
          </.form>
          <%= if assigns[:message], do: assigns.message %>
        </main>
        """
      })

    Pages.create_page!(%{
      path: "blog/:blog_slug",
      site: default_site(),
      layout_id: layout_id,
      template: """
      <main>
        <h2>A blog</h2>
        <ul>
          <li>Path Params Blog Slug: <%= @beacon_path_params.blog_slug %></li>
          <li>Live Data blog_slug_uppercase: <%= @beacon_live_data.blog_slug_uppercase %></li>
        </ul>
      </main>
      """
    })

    Pages.create_page_event!(%{
      page_id: page_id,
      event_name: "hello",
      code: """
        {:noreply, Phoenix.Component.assign(socket, :message, "Hello \#{event_params["greeting"]["name"]}!")}
      """
    })
  end
end
