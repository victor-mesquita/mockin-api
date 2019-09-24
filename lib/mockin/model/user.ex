defmodule Mockin.Model.User do
  @moduledoc """
  The User model.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Mockin.Model.{Segment, SubSegment}

  @required_fields ~w(msisdn segment_id)a
  @optional_fields ~w(name subsegment_id)a

  schema "user" do
    field(:msisdn, :string)
    field(:name, :string)

    belongs_to(:segment, Segment,  foreign_key: :segment_id)
    belongs_to(:sub_segment, SubSegment, foreign_key: :subsegment_id)

    has_many(:user_routes, Mockin.Model.RouteDetail)

    timestamps(inserted_at: :created_at)
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:msisdn, name: :user_msisdn_index)
  end
end
