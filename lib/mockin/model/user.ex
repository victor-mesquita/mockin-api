defmodule Mockin.Model.User do
  use Ecto.Schema
  use Pow.Ecto.Schema
  alias Mockin.Model.{Role}

  schema "user" do
    field :name, :string
    field(:role_id, :integer, default: Role.roles[:admin])

    pow_user_fields()

    timestamps()
  end

  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> pow_changeset(attrs)
    |> Ecto.Changeset.cast(attrs, [:name])
    |> Ecto.Changeset.validate_required([:name])
  end

  @spec changeset_role(Ecto.Schema.t() | Ecto.Changeset.t(), map()) :: Ecto.Changeset.t()
  def changeset_role(user_or_changeset, attrs) do
    user_or_changeset
    |> Ecto.Changeset.cast(attrs, [:role])
    |> Ecto.Changeset.validate_inclusion(:role, ~w(1 2))
  end
end
