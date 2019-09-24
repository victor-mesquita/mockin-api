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

  def dynamicRouteResponse(conn, method) do
    path = conn.request_path
    [user] = conn |> get_req_header("authorization")
    route = Routes.get_route(path, method)

    if route == nil do
      conn
      |> send_resp(404, "")
    else
      user_route = Routes.get_user_route_by_msisdn(user, route.id)
      if user_route == nil do
        conn
        |> send_resp(404, "")
      else
        conn
        |> put_resp_header("content-type", "application/json; charset=utf-8")
        |> send_resp(user_route.status_code, user_route.response)
      end
    end
  end

end
