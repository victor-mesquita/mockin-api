defmodule MockinWeb.MockUserController do
  use MockinWeb, :controller

  alias Mockin.Repository.MockUsers

  action_fallback(MockinWeb.FallbackController)

  def index(conn, params) do
    project_id = params["project_id"]
    pagination = Map.delete(params, :project_id)

    mock_users = MockUsers.list(project_id, pagination)

    render(conn, "index.json", mock_users: mock_users)
  end

  def get(conn, params) do
    # params["project_id"]
    mock_user = MockUsers.get_user!(params["id"])

    render(conn, "show_minimal.json", mock_user: mock_user)
  end

  def update(conn, params) do
    mock_user_params = params["mock_user"]
    mock_user_id = mock_user_params["id"]

    mock_user = MockUsers.get_user!(mock_user_id)

    case MockUsers.update_user(mock_user, mock_user_params) do
      {:ok, mock_user_result} ->
        conn
        |> put_status(200)
        |> render("show.json", mock_user: mock_user_result)

      {:error, changeset} ->
        conn
        |> put_status(400)
        |> render(MockinWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def create(conn, %{"mock_user" => mock_user_params}) do
    case MockUsers.create_user(mock_user_params) do
      {:ok, mock_user} ->
        conn
        |> put_status(:created)
        |> render("show.json", mock_user: mock_user)

      {:error, changeset} ->
        conn
        |> put_status(400)
        |> render(MockinWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, params) do
    mock_user_id = params["id"]

    mock_user = MockUsers.get_user!(mock_user_id)

    case MockUsers.delete_user(mock_user) do
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
