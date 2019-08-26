defmodule MockinWeb.RouteController do
  use MockinWeb, :controller

  alias Mockin.Model.Routes

  action_fallback(MockinWeb.FallbackController)

  def index(conn, params) do
    routes =
      Routes.list_routes(params)

    render(conn, "index.json", routes: routes)
  end

  def create(conn, %{"route" => route_params }) do
    case Routes.create_route(route_params) do
      {:ok, route} ->

        conn
        |> put_status(:created)
        |> render("show.json", route: route)

      {:error, changeset} ->
        render(conn, MockinWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
