defmodule Mockin.Repository.Routes do
  @moduledoc """
  The boundry for the Routes system
  """

  import Ecto.Query, warn: false
  alias Mockin.Repo
  alias Mockin.Model.{Route, UserRoutes}

  @default_pagination_limit 10
  @default_offset 0

  def get_route!(id), do: Repo.get!(Route, id)

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
end
