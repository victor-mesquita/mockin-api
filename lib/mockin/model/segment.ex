defmodule Mockin.Model.Segment do
    @moduledoc """
    The Segment model.
    """

    use Ecto.Schema
    import Ecto.Changeset
    alias Mockin.Model.{SubSegment}

    @required_fields ~w(name)a

    schema "segment" do
      field(:name, :string)

      has_many(:sub_seguement, SubSegment)
      # timestamps(inserted_at: :created_at)
    end

    def changeset(user, attrs) do
      user
      |> cast(attrs, @required_fields)
      |> validate_required(@required_fields)
    end
  end
