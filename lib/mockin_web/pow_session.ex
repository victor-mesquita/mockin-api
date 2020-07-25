defmodule MockinWeb.Pow.Plug do
    use Pow.Plug.Base

    @session_key :pow_user_token
    @salt "user auth"
    @max_age 86400

    def fetch(conn, _) do
      conn  = Plug.Conn.fetch_session(conn)
      token = Plug.Conn.get_session(conn, @session_key)

      MockinWeb.Endpoint
      |> Phoenix.Token.verify(@salt, token, max_age: @max_age)
      |> maybe_load_user(conn)
    end

    defp maybe_load_user({:ok, user_id}, conn), do: {conn, Mockin.Repo.get(User, user_id)}
    defp maybe_load_user({:error, _any}, conn), do: {conn, nil}

    def create(conn, user, _) do
      token = Phoenix.Token.sign(MockinWeb.Endpoint, @salt, user.id)
      conn  =
        conn
        |> Plug.Conn.fetch_session()
        |> Plug.Conn.put_session(@session_key, token)

      {conn, user}
    end

    def delete(conn, _) do
      conn
      |> Plug.Conn.fetch_session()
      |> Plug.Conn.delete_session(@session_key)
    end
  end
