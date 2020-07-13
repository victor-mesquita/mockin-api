defmodule Mockin.Repository.MockUsers do
  @moduledoc """
  The boundry for the MockUsers system
  """

  import Ecto.Query, warn: false
  alias Mockin.Repo
  alias Mockin.Model.MockUser

  @default_routes_pagination_limit 1000

  def get_user!(id), do: Repo.get!(MockUser, id)

  def get_by_msisdn(msisdn) do
    from(mock_user in MockUser, where: mock_user.msisdn == ^msisdn)
    |> Repo.all
    |> List.first
  end

  def delete_user(mock_user) do
    Repo.delete(mock_user)
  end

  def list(params) do
    limit = params["limit"] || @default_routes_pagination_limit
    offset = params["offset"] || 0

    from(mock_user in MockUser, limit: ^limit, offset: ^offset)
      |> order_by(:created_at)
      |> Repo.all
  end

  def create_user(attrs \\ %{}) do
    %MockUser{}
    |> MockUser.changeset(attrs)
    |> Repo.insert()
  end


  def update_user(mock_user, attrs) do
    mock_user
    |> MockUser.changeset(attrs)
    |> Repo.update()
  end
end
