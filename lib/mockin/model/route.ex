defmodule Mockin.Model.Route do
    @moduledoc """
    The Route model.
    """

    use Ecto.Schema
    import Ecto.Changeset

    @required_fields ~w(path httpMethod)a

    schema "route" do
      field(:path, :string)
      field(:httpMethod, :string)
    end

    def changeset(user, attrs) do
      user
      |> cast(attrs, @required_fields)
      |> validate_required(@required_fields)
    end
  end
