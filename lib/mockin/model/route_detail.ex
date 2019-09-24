defmodule Mockin.Model.RouteDetail do
    @moduledoc """
    The Route Detail model.
    """

    use Ecto.Schema
    import Ecto.Changeset

    @required_fields ~w(user_id route_id status_code active response)a

    schema "route_details" do
      field(:status_code, :integer)
      field(:active, :boolean)
      field(:response, :string)
      field(:user_id, :integer, primary_key: true)
      field(:route_id, :integer, primary_key: true)
    end

    def changeset(user, attrs) do
      user
      |> cast(attrs, @required_fields)
      |> validate_required(@required_fields)
      |> unique_constraint(:user_id, name: :user_route_msisdn_key)
      |> unique_constraint(:route_id, name: :user_route_pkey)
      |> foreign_key_constraint(:user_id)
      |> foreign_key_constraint(:route_id)
    end
  end
