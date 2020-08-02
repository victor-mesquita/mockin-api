defmodule Mockin.Model.ProjectMember do
  use Ecto.Schema

  schema "project_member" do
    field :user_id, :integer
    field :project_id, :integer
    field :default, :boolean

    timestamps()
  end

  def changeset(project_member, attrs) do
    project_member
    |> Ecto.Changeset.cast(attrs, [:default, :user_id, :project_id])
  end
end
