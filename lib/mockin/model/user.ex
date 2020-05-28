defmodule Mockin.Model.User do
  @moduledoc """
  The User model.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @required_fields ~w(msisdn)a
  @optional_fields ~w(name)a

  schema "user" do
    field(:msisdn, :string)
    field(:name, :string)

    has_many(:user_routes, Mockin.Model.RouteDetail, on_delete: :delete_all)

    timestamps(inserted_at: :created_at)
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:msisdn, name: :user_msisdn_index)
  end
end
