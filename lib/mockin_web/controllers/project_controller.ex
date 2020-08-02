defmodule MockinWeb.ProjectController do
  use MockinWeb, :controller

  alias Mockin.Repository.Projects
  alias MockinWeb.APIAuthPlug

  action_fallback(MockinWeb.FallbackController)

  def index(conn, _) do
    config = Pow.Plug.fetch_config(conn)
    conn
    |> APIAuthPlug.fetch(config)
    |> case do
      {conn, nil} ->
        conn
        |> put_status(401)
        |> json(%{error: %{status: 401, message: "Token inválido"}})

      {conn, user} ->
        projects = user.id
        |> Projects.list_user_projects

        conn
        |> put_status(200)
        |> render("index.json", projects: projects)
    end
  end
end
