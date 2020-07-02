defmodule Mockin.Repository.Users do
  @moduledoc """
  The boundry for the Users system
  """

  import Ecto.Query, warn: false
  alias Mockin.Repo
  alias Mockin.Model.User

  @default_routes_pagination_limit 1000

  def get_user!(id), do: Repo.get!(User, id)

  def get_by_msisdn(msisdn) do
    from(user in User, where: user.msisdn == ^msisdn)
    |> Repo.all
    |> List.first
  end

  def delete_user(user) do
    Repo.delete(user)
  end

  def list(params) do
    limit = params["limit"] || @default_routes_pagination_limit
    offset = params["offset"] || 0

    from(user in User, limit: ^limit, offset: ^offset)
      |> order_by(:created_at)
      |> Repo.all
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end


  def update_user(user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end
end
