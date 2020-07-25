defmodule Mockin.Repository.Users do
   import Ecto.Query, warn: false
    alias Mockin.{Repo, Model.User, Model.Role}

    @type t :: %User{}

    @spec create_admin(map()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
    def create_admin(params) do
      %User{}
      |> User.changeset(params)
      |> User.changeset_role(%{role: Role.roles()[:admin]})
      |> Repo.insert()
    end
  
    @spec set_admin_role(t()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
    def set_admin_role(user) do
      user
      |> User.changeset_role(%{role: Role.roles()[:admin]})
      |> Repo.update()
    end
  end