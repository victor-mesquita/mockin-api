defmodule Mockin.Repository.Routes do
  @moduledoc """
  The boundry for the Routes system
  """

  import Ecto.Query, warn: false
  alias Mockin.Repo
  alias Mockin.Model.{Route, RouteDetail}
  alias Mockin.Repository.Users

  @default_pagination_limit 10
  @default_offset 0

  def get_route!(id), do: Repo.get!(Route, id)

  def get_route(path, http_method) do
    from(route in Route, where: route.path == ^path and route.http_method == ^http_method)
    |> Repo.all
    |> List.first
  end

  def get_route_detail(user_id, route_id) do
    from(user_detail in RouteDetail, where: user_detail.user_id == ^user_id and user_detail.route_id == ^route_id)
    |> Repo.all
    |> List.first
  end

  def get_route_detail_by_msisdn(msisdn, route_id) do
    user = Users.get_by_msisdn(msisdn)

    from(user_detail in RouteDetail, where: user_detail.user_id == ^user.id and user_detail.route_id == ^route_id)
    |> Repo.all
    |> List.first
  end

  def list_route_detail(params) do
    limit = params["limit"] || @default_pagination_limit
    offset = params["offset"] || @default_offset

    from(route_detail in RouteDetail, limit: ^limit, offset: ^offset)
      |> Repo.all
  end

  def list_routes(params) do
    limit = params["limit"] || @default_pagination_limit
    offset = params["offset"] || @default_offset

    from(route in Route, limit: ^limit, offset: ^offset)
      |> Repo.all
  end

  def create_route(attrs \\ %{}) do
    %Route{}
    |> Route.changeset(attrs)
    |> Repo.insert()
  end

  def create_route_detail(attrs \\ %{}) do
    %RouteDetail{}
    |> RouteDetail.changeset(attrs)
    |> Repo.insert()
  end

  def update_user_route(user_route, attrs) do
    user_route
    |> RouteDetail.changeset(attrs)
    |> Repo.update()
  end
end
