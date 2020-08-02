defmodule MockinWeb.APIAuthErrorHandler do
    use MockinWeb, :controller
    alias Plug.Conn
  
    @spec call(Conn.t(), :not_authenticated) :: Conn.t()
    def call(conn, :not_authenticated) do
      conn
      |> put_status(401)
      |> json(%{error: %{code: 401, message: "Usuário não autorizado!"}})
    end
  end