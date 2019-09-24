defmodule MockinWeb.UserRouteView do
  use MockinWeb, :view
  alias MockinWeb.{UserRouteView, FormatHelpers}

  def render("index.json", %{userRoutes: userRoutes}) do
    %{
      userRoutes: render_many(userRoutes, UserRouteView, "user_routes.json")
    }
  end

  def render("show.json", %{user_route: user_route}) do
    %{userRoute: render_one(user_route, UserRouteView, "user_route.json")}
  end

  def render("user_route.json", %{user_route: user_route}) do
    user_route
    |> Map.from_struct()
    |> Map.take([
      :status_code,
      :active,
      :response,
      :user_id,
      :route_id,
      :id
    ])
    |> FormatHelpers.camelize()
  end
end
