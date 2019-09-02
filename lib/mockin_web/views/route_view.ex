defmodule MockinWeb.RouteView do
  use MockinWeb, :view
  alias MockinWeb.{RouteView, FormatHelpers}

  def render("index.json", %{routes: routes}) do
    %{
      routes: render_many(routes, RouteView, "routes.json")
    }
  end

  def render("show.json", %{route: route}) do
    %{route: render_one(route, RouteView, "route.json")}
  end

  def render("route.json", %{route: route}) do
    route
    |> Map.from_struct()
    |> Map.take([
      :id,
      :path
    ])
    |> FormatHelpers.camelize()
  end
end
