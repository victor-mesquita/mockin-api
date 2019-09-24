defmodule Mockin.Repository.Routes do
  @moduledoc """
  The boundry for the Routes system
  """

  import Ecto.Query, warn: false
  alias Mockin.Repo
  alias Mockin.Model.{Route, UserRoutes}
  alias Mockin.Repository.Users

  @default_pagination_limit 10
  @default_offset 0

  def get_route!(id), do: Repo.get!(Route, id)

  def get_route(path, http_method) do
    from(route in Route, where: route.path == ^path and route.http_method == ^http_method)
    |> Repo.all
    |> List.first
  end

  def get_user_route(user_id, route_id) do
    from(userRoute in UserRoutes, where: userRoute.user_id == ^user_id and userRoute.route_id == ^route_id)
    |> Repo.all
    |> List.first
  end

  def get_user_route_by_msisdn(msisdn, route_id) do
    user = Users.get_by_msisdn(msisdn)

    from(userRoute in UserRoutes, where: userRoute.user_id == ^user.id and userRoute.route_id == ^route_id)
    |> Repo.all
    |> List.first
  end

  def list_user_routes(params) do
    limit = params["limit"] || @default_pagination_limit
    offset = params["offset"] || @default_offset

    from(route in UserRoutes, limit: ^limit, offset: ^offset)
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

  def create_user_route(attrs \\ %{}) do
    %UserRoutes{}
    |> UserRoutes.changeset(attrs)
    |> Repo.insert()
  end

  def update_user_route(user_route, attrs) do
    user_route
    |> UserRoutes.changeset(attrs)
    |> Repo.update()
  end
end
