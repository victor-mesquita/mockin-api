defmodule Mockin.Model.SubSegment do
    @moduledoc """
    The SubSegment model.
    """

    use Ecto.Schema
    import Ecto.Changeset

    alias Mockin.Model.Segment

    @required_fields ~w(name segment_id)a

    schema "sub_seguement" do
      field(:name, :string)
      # field(:segment_id, :integer, primary_key: true)

      belongs_to(:segment, Segment, foreign_key: :segment_id)
    end

    def changeset(user, attrs) do
      user
      |> cast(attrs, @required_fields)
      |> validate_required(@required_fields)
    end
  end
