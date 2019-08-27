defmodule MockinWeb.UserController do
  use MockinWeb, :controller

  alias Mockin.Model.Users
  alias Mockin.Repo

  action_fallback(MockinWeb.FallbackController)

  def index(conn, params) do
    users =
      Users.list(params)

    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params }) do
    case Users.create_user(user_params) do
      {:ok, user} ->

        user =
          user
          |> Repo.preload([:segment, :sub_segment])

        conn
        |> put_status(:created)
        |> render("show.json", user: user)

      {:error, changeset} ->
        render(conn, MockinWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
