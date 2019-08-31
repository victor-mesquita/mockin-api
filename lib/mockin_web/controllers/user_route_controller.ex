defmodule MockinWeb.UserRouteController do
  use MockinWeb, :controller

  alias Mockin.Repository.Routes

  action_fallback(MockinWeb.FallbackController)

  def index(conn, params) do
    routes =
      Routes.list_user_routes(params)

    render(conn, "index.json", routes: routes)
  end

  def create(conn, %{"route" => route_params }) do
    case Routes.create_user_route(route_params) do
      {:ok, route} ->

        conn
        |> put_status(:created)
        |> render("show.json", route: route)

      {:error, changeset} ->
        render(conn, MockinWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
