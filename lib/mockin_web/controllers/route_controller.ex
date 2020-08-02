defmodule MockinWeb.RouteController do
  use MockinWeb, :controller

  alias Mockin.Repository.Routes
  alias Mockin.Repository.MockUsers

  action_fallback(MockinWeb.FallbackController)

  def index(conn, params) do
    user = MockUsers.get_by_msisdn(params["msisdn"])

    params = Map.put(params, "user_id", user.id)

    routes = Routes.list_routes(params)

    render(conn, "index.json", routes: routes)
  end

  def get(conn, params) do
    route = Routes.get_route!(params["id"])

    render(conn, "show.json", route: route)
  end

  def create(conn, %{route: route}) do
    case Routes.create_route(route) do
      {:ok, route} ->
        conn
        |> put_status(:created)
        |> render("show.json", route: route)

      {:error, changeset} ->
        conn
        |> put_status(400)
        |> render(MockinWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, params) do
    route_id = params["id"]

    route = Routes.get_route!(route_id)

    case Routes.delete_route(route) do
      {:ok, _} ->
        conn
        |> send_resp(200, "{}")

      {:error, changeset} ->
        conn
        |> put_status(400)
        |> render(MockinWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def update(conn, %{"route" => route_params}) do
    route_id = route_params["id"]

    route = Routes.get_route!(route_id)

    case Routes.update_route(route, route_params) do
      {:ok, route} ->
        conn
        |> put_status(200)
        |> render("show.json", route: route)

      {:error, changeset} ->
        conn
        |> put_status(400)
        |> render(MockinWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
