defmodule MockinWeb.RouteDetailController do
  use MockinWeb, :controller

  alias Mockin.Repository.{Routes}

  action_fallback(MockinWeb.FallbackController)

  def get(conn, params) do
    user_id = params["user_id"]
    route_id = params["route_id"]

    route_detail = Routes.get_route_detail(user_id, route_id)

    render(conn, "show.json", route_detail: route_detail)
  end

  def index(conn, params) do
    route_details = Routes.list_route_detail(params)

    render(conn, "index.json", route_details: route_details)
  end

  def create(conn, params) do

    route_params = params["route_detail"]

    case Routes.create_route_detail(route_params) do
      {:ok, route_detail} ->
        conn
        |> put_status(:created)
        |> render("show.json", route_detail: route_detail)

      {:error, changeset} ->
        conn
        |> put_status(400)
        |> render(MockinWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def update(conn, params) do
    route_params = params["route_detail"]
    user_id = route_params["user_id"]
    route_id = route_params["route_id"]

    route_detail = Routes.get_route_detail(user_id, route_id)

    case Routes.update_user_route(route_detail, route_params) do
      {:ok, route_detail} ->
        conn
        |> put_status(200)
        |> render("show.json", route_detail: route_detail)

      {:error, changeset} ->
        conn
        |> put_status(400)
        |> render(MockinWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, params) do
    user_id = params["user_id"]
    route_id = params["route_id"]

    route_detail = Routes.get_route_detail(user_id, route_id)

    case Routes.delete_route_detail(route_detail) do
      {:ok, _} ->
        conn
        |> send_resp(200, "{}")

      {:error, changeset} ->
        conn
        |> put_status(400)
        |> render(MockinWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
