defmodule Mockin.Model.Route do
    @moduledoc """
    The Route model.
    """

    use Ecto.Schema
    import Ecto.Changeset

    @required_fields ~w(id path)a

    schema "route" do
      field(:path, :string)
      # timestamps(inserted_at: :created_at)
    end

    def changeset(user, attrs) do
      user
      |> cast(attrs, @required_fields)
      |> validate_required(@required_fields)
    end
  end
