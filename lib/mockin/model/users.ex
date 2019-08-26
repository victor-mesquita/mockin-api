defmodule Mockin.Model.Users do
  @moduledoc """
  The boundry for the Users system
  """

  import Ecto.Query, warn: false
  alias Mockin.Repo
  alias Mockin.Model.User

  @default_routes_pagination_limit 10

  def get_user!(id), do: Repo.get!(User, id)

  def list(params) do
    limit = params["limit"] || @default_routes_pagination_limit
    offset = params["offset"] || 0

    from(user in User, limit: ^limit, offset: ^offset)
      |> Repo.all
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
