defmodule MockinWeb.RegistrationController do
    use MockinWeb, :controller
  
    alias Ecto.Changeset
    alias Plug.Conn
    alias MockinWeb.ErrorHelpers
  
    @spec create(Conn.t(), map()) :: Conn.t()
    def create(conn, %{"user" => user_params}) do
      conn
      |> Pow.Plug.create_user(user_params)
      |> case do
        {:ok, _user, conn} ->
          json(conn, %{accessToken: conn.private[:api_access_token], renewalToken: conn.private[:api_renewal_token]})
  
        {:error, changeset, conn} ->
          errors = Changeset.traverse_errors(changeset, &ErrorHelpers.translate_error/1)
  
          conn
          |> put_status(500)
          |> json(%{error: %{status: 500, message: "Falha ao criar usuário", errors: errors}})
      end
    end
  end