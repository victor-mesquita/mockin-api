defmodule MockinWeb.DynamicController do
  use MockinWeb, :controller
  alias Mockin.Repository.Routes

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
      |> send_resp(404, "Defina um usuario no header authorization, ex: Authorization: 219999999999")
    else
      user_without_bearer = user_id
        |> String.replace("Bearer ", "")
    end
  end

  def dynamicRouteResponse(conn, method) do
    path = conn.request_path
    user = get_user_from_header(conn)

    route = Routes.get_route(path, method)

    if route == nil do
      conn
      |> send_resp(404, "")
    else
      try do
      route_detail = Routes.get_route_detail_by_msisdn(user, route.id)

      if route_detail == nil do
        conn
        |> send_resp(404, "")
      else
        conn
        |> put_resp_header("content-type", "application/json; charset=utf-8")
        |> send_resp(route_detail.status_code, route_detail.response)
      end
     after
        conn
        |> send_resp(400, "Falha ao retornar dados para esse usuário")
      end

    end
  end
end
