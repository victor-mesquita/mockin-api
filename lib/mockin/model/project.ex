defmodule Mockin.Model.Project do
  use Ecto.Schema

  schema "project" do
    field :name, :string
    field :description, :string
    field :unique_name, :string

    many_to_many :users, Mockin.Model.User, join_through: "project_member"

    timestamps()
  end

  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> Ecto.Changeset.cast(attrs, [:name, :description, :unique_name])
    |> Ecto.Changeset.validate_required([:name, :description, :unique_name])
  end
end
