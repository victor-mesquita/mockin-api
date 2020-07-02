defmodule Mockin.Repository.Routes do
  @moduledoc """
  The boundry for the Routes system
  """

  import Ecto.Query, warn: false
  alias Mockin.Repo
  alias Mockin.Model.{Route}

  @default_pagination_limit 1000
  @default_offset 0

  def get_route!(id), do: Repo.get!(Route, id)

  def get_route(path, http_method, user_id) do
    from(route in Route, where: route.path == ^path and route.http_method == ^http_method and route.user_id == ^user_id)
    |> Repo.all
    |> List.first
  end

  def delete_route(route) do
    Repo.delete(route)
  end

  def list_routes(params) do
    limit = params["limit"] || @default_pagination_limit
    offset = params["offset"] || @default_offset
    user_id = params["user_id"]

    from(route in Route, where:  route.user_id == ^user_id, limit: ^limit, offset: ^offset)
      |> order_by(:created_at)
      |> Repo.all
  end

  def create_route(attrs \\ %{}) do

    %Route{}
    |> Route.changeset(attrs)
    |> Repo.insert()
  end


  def update_route(route, attrs) do
    route
    |> Route.changeset(attrs)
    |> Repo.update()
  end
end
