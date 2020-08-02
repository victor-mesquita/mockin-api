defmodule Mockin.Repository.Projects do
  @moduledoc """
  The boundry for the Project system
  """
  import Ecto.Query, warn: false
  alias Mockin.{Repo, Model.User, Model.Project}

  @default_pagination_limit 1000

  def get_project!(id), do: Repo.get!(Project, id)

  def get_project_by_unique_name!(unique_name) do
    from(project in Project, where: project.unique_name == ^unique_name)
    |> Repo.all()
    |> List.first()
  end

  def delete_project(project) do
    Repo.delete(project)
  end

  def list(params) do
    limit = params["limit"] || @default_pagination_limit
    offset = params["offset"] || 0

    from(project in Project, limit: ^limit, offset: ^offset)
    |> order_by(:created_at)
    |> Repo.all()
  end

  def create_project(attrs \\ %{}) do
    %Project{}
    |> Project.changeset(attrs)
    |> Repo.insert()
  end

  def update_project(project, attrs) do
    project
    |> Project.changeset(attrs)
    |> Repo.update()
  end

  def list_user_projects(user_id) do
    user =
      from(user in User, where: user.id == ^user_id)
      |> Repo.one()
      |> Repo.preload(:projects)

    user.projects
  end
end
