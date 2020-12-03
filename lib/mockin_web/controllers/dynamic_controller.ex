defmodule MockinWeb.DynamicController do
  use MockinWeb, :controller
  alias Mockin.Repository.{Projects, Routes, MockUsers}

  action_fallback(MockinWeb.FallbackController)

  def get(conn, params) do
    method = "GET"
    project_unique_name = params[:project_unique_name]

    conn
    |> dynamicRouteResponse(method, project_unique_name)
  end

  def post(conn, params) do
    method = "POST"
    project_unique_name = params[:project_unique_name]

    conn
    |> dynamicRouteResponse(method, project_unique_name)
  end

  def put(conn, params) do
    method = "PUT"
    project_unique_name = params[:project_unique_name]

    conn
    |> dynamicRouteResponse(method, project_unique_name)
  end

  def patch(conn, params) do
    method = "PATCH"
    project_unique_name = params[:project_unique_name]

    conn
    |> dynamicRouteResponse(method, project_unique_name)
  end

  def delete(conn, params) do
    method = "DELETE"
    project_unique_name = params[:project_unique_name]

    conn
    |> dynamicRouteResponse(method, project_unique_name)
  end

  def get_user_from_header(conn) do
    user_id =
      conn
      |> get_req_header("authorization")
      |> List.first()

    IO.puts("Usuário identificado: #{user_id}")

    if user_id == nil do
      conn
      |> put_resp_header("content-type", "application/json; charset=utf-8")
      |> send_resp(
        404,
        "Defina um usuario no header authorization, ex: Authorization: Bearer 219999999999"
      )
    else
      user_id
      |> String.replace("Bearer ", "")
    end
  end

  def dynamicRouteResponse(conn, method, project_unique_name) do
    path =
      conn.request_path
      |> String.replace("/#{project_unique_name}", "")

    msisdn = get_user_from_header(conn)
    project = Projects.get_project_by_unique_name!(project_unique_name)
    user = MockUsers.get_by_msisdn_project_id(msisdn, project.id)

    if user == nil or project == nil do
      conn
      |> put_status(404)
      |> json(%{error: %{status: 404, message: "Usuário ou projeto não encontrados!"}})
    else
      IO.puts("Path: #{path}")
      route = Routes.get_route(path, method, user.id, project.id)

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
