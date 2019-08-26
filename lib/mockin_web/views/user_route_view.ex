defmodule MockinWeb.UserRouteView do
  use MockinWeb, :view
  alias MockinWeb.{UserRouteView, FormatHelpers}

  def render("index.json", %{userRoutes: userRoutes}) do
    %{
      routes: render_many(userRoutes, UserRouteView, "user_routes.json"),
      routesCount: length(userRoutes)
    }
  end

  def render("show.json", %{route: route}) do
    %{route: render_one(route, UserRouteView, "show.json")}
  end

  def render("user_route.json", %{route: route}) do
    route
    |> Map.from_struct()
    |> Map.take([
      :statusCode,
      :httpMethod,
      :active,
      :response
    ])
    |> FormatHelpers.camelize()
  end
end
