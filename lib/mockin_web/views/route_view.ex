defmodule MockinWeb.RouteView do
  use MockinWeb, :view
  alias MockinWeb.{RouteView, FormatHelpers}

  def render("index.json", %{routes: routes}) do
    %{
      routes: render_many(routes, RouteView, "route.json")
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
      :path,
      :description,
      :http_method,
      :status_code,
      :active,
      :response,
      :user_id,
    ])
    |> FormatHelpers.camelize()
  end
end
