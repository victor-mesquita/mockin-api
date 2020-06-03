defmodule MockinWeb.DynamicController do
  use MockinWeb, :controller
  alias Mockin.Repository.Routes
  alias Mockin.Repository.Users

  action_fallback(MockinWeb.FallbackController)

  def get(conn, _) do
    method = "GET"

    conn
    |> dynamicRouteResponse(method)
  end

  def post(conn, _) do
    method = "POST"

    conn
    |> dynamicRouteResponse(method)
  end

  def put(conn, _) do
    method = "PUT"

    conn
    |> dynamicRouteResponse(method)
  end

  def patch(conn, _) do
    method = "PATCH"

    conn
    |> dynamicRouteResponse(method)
  end

  def delete(conn, _) do
    method = "DELETE"

    conn
    |> dynamicRouteResponse(method)
  end

  def get_user_from_header(conn) do
    user_id = conn
    |> get_req_header("authorization")
    |> List.first

    IO.puts "Usuário identificado: #{user_id}"

    if user_id == nil do
      conn
      |> put_resp_header("content-type", "application/json; charset=utf-8")
      |> send_resp(404, "Defina um usuario no header authorization, ex: Authorization: Bearer 219999999999")
    else
      user_id
        |> String.replace("Bearer ", "")
    end
  end

  def dynamicRouteResponse(conn, method) do
    path = conn.request_path
    msisdn = get_user_from_header(conn)
    user = Users.get_by_msisdn(msisdn)

    if user == nil do
      conn
      |> send_resp(401, "")
    else
      IO.puts "Path: #{path}"
      route = Routes.get_route(path, method, user.id)
      try do
        if route == nil do
          conn
          |> send_resp(404, "Rota não encontrada")
        else
          conn
          |> put_resp_header("content-type", "application/json; charset=utf-8")
          |> send_resp(route.status_code, route.response)
        end
      after
        conn
        |> send_resp(400, "Falha ao retornar dados para esse usuário")
      end

    end
  end
end
