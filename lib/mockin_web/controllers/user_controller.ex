defmodule MockinWeb.UserController do
  use MockinWeb, :controller

  alias MockinWeb.APIAuthPlug

  action_fallback(MockinWeb.FallbackController)

  def get(conn, _) do
    config = Pow.Plug.fetch_config(conn)
    conn
    |> APIAuthPlug.fetch(config)
    |> case do
      {conn, nil} ->
        conn
        |> put_status(401)
        |> json(%{error: %{status: 401, message: "Token inválido"}})

      {conn, user} ->
        conn
        |> put_status(200)
        |> render("show.json", user: user)
    end
  end
end
