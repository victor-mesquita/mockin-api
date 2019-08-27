defmodule Mockin.Model.Segment do
    @moduledoc """
    The Segment model.
    """

    use Ecto.Schema
    import Ecto.Changeset
    alias Mockin.Model.{SubSegment, User}

    @required_fields ~w(name)a

    schema "segment" do
      field(:name, :string)

      has_many(:sub_segment, SubSegment)
      has_many(:user, User)
      # timestamps(inserted_at: :created_at)
    end

    def changeset(segment, attrs) do
      segment
      |> cast(attrs, @required_fields)
      |> validate_required(@required_fields)
    end
  end
