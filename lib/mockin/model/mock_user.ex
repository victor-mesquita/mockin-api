defmodule Mockin.Model.MockUser do
  @moduledoc """
  The Mock User model.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @required_fields ~w(msisdn project_id)a
  @optional_fields ~w(description)a

  schema "mock_user" do
    field(:msisdn, :string)
    field(:description, :string)
    field(:project_id, :integer)

    has_many(:mock_user_routes, Mockin.Model.Route, on_delete: :delete_all)

    timestamps(inserted_at: :created_at)
  end

  def changeset(mock_user, attrs) do
    mock_user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint([:msisdn, :project_id], name: :mock_user_msisdn_index)
  end
end
