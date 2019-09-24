defmodule MockinWeb.UserRouteController do
  use MockinWeb, :controller

  alias Mockin.Repository.{Routes}

  action_fallback(MockinWeb.FallbackController)

  def get(conn, params) do
    user_id = params["user_id"]
    route_id = params["route_id"]

    user_route = Routes.get_user_route(user_id, route_id)

    render(conn, "show.json", user_route: user_route)
  end

  def index(conn, params) do
    routes = Routes.list_user_routes(params)

    render(conn, "index.json", userRoutes: routes)
  end

  def create(conn, params) do

    route_params = params["user_route"]

    case Routes.create_user_route(route_params) do
      {:ok, route} ->
        conn
        |> put_status(:created)
        |> render("show.json", user_route: route)

      {:error, changeset} ->
        conn
        |> put_status(400)
        |> render(MockinWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def update(conn, params) do
    route_params = params["user_route"]
    user_id = route_params["user_id"]
    route_id = route_params["route_id"]

    user_route = Routes.get_user_route(user_id, route_id)

    case Routes.update_user_route(user_route, route_params) do
      {:ok, route} ->
        conn
        |> put_status(200)
        |> render("show.json", user_route: route)

      {:error, changeset} ->
        conn
        |> put_status(400)
        |> render(MockinWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
