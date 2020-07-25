defmodule MockinWeb.ResetPasswordController do
  use MockinWeb, :controller

  alias Plug.Conn
  alias PowResetPassword.{Phoenix.Mailer, Plug}

  @spec create(Conn.t(), map()) :: Conn.t()
  def create(conn, %{"user" => user_params}) do
    case Plug.create_reset_token(conn, user_params) do
      {:ok, %{token: token, user: user}, conn} ->
        url = confirmation_url(token)
        deliver_email(conn, user, url)
        conn |> create_success()

      {:error, _any, conn} ->
        conn
        |> create_success()
    end
  end

  def update(conn, %{"user" => user_params, "id" => token}) do
    case Plug.load_user_by_token(conn, token) do
      {:error, conn} ->
        conn
        |> put_status(400)
        |> json(%{error: %{status: 400, message: "Token de atualização de senha inválido"}})

      {:ok, conn} ->
        update_user(conn, user_params)
    end

    conn
    |> json(%{success: %{message: "Reset password"}})
  end

  defp update_user(conn, user_params) do
    # conn = conn |> Plug.assign_reset_password_user(user_params)

    case Plug.update_user_password(conn, user_params) do
      {:ok, _user, conn} ->
        conn
        |> json(%{success: %{message: "Senha atualizada com sucesso!"}})

      {:error, changeset, conn} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(MockinWeb.ChangesetView)
        |> render("error.json", changeset: changeset)
    end
  end

  defp create_success(conn) do
    conn |> json(%{success: %{message: "Te enviamos um e-mail para você redefinir sua senha!"}})
  end

  defp confirmation_url(token) do
    Application.get_env(:mockin, MockinWeb.Endpoint)[:front_end_reset_password_url]
    |> String.replace("{token}", token)
  end

  defp deliver_email(conn, user, url) do
    email = Mailer.reset_password(conn, user, url)
    Pow.Phoenix.Mailer.deliver(conn, email)
  end
end
