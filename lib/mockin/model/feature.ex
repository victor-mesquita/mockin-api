defmodule Mockin.Model.Feature do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields ~w(name active)a

  schema "feature" do
    field :name, :string
    field :active, :boolean

    timestamps()
  end

  def changeset(feature, attrs) do
    feature
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
