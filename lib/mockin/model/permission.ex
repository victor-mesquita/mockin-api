defmodule Mockin.Model.Permission do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields ~w(role_id feature_id)a
  
  @primary_key false
  schema "permission" do
    field(:role_id, :integer, default: 1)
    field(:feature_id, :integer, default: 1)

    timestamps()
  end

  def changeset(permission, attrs) do
    permission
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:role_id)
    |> foreign_key_constraint(:feature_id)

  end
end
