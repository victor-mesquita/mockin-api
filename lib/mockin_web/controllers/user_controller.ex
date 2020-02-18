defmodule MockinWeb.UserController do
  use MockinWeb, :controller

  alias Mockin.Repository.Users
  alias Mockin.Repo

  action_fallback(MockinWeb.FallbackController)

  def index(conn, params) do
    users =
      Users.list(params)
      |> Repo.preload([:segment, :sub_segment])

    render(conn, "index.json", users: users)
  end

  def get(conn, params) do
    user =
      Users.get_user!(params["id"])
      |> Repo.preload([:segment, :sub_segment])

    render(conn, "show_minimal.json", user: user)
  end

  def update(conn, params) do
    user_params = params["user"]
    user_id = user_params["id"]

    user = Users.get_user!(user_id)

    case Users.update_user(user, user_params) do
      {:ok, user_result} ->
        conn
        |> put_status(200)
        |> render("show.json", user: user_result)

      {:error, changeset} ->
        conn
        |> put_status(400)
        |> render(MockinWeb.ChangesetView, "error.json", changeset: changeset)
    end
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
        conn
        |> put_status(400)
        |> render(MockinWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, params) do
    user_id = params["id"]

    user = Users.get_user!(user_id)

    case Users.delete_user(user) do
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
