defmodule Mockin.Model.UserRoutes do
    @moduledoc """
    The User Routes model.
    """

    use Ecto.Schema
    import Ecto.Changeset

    @required_fields ~w(user_id route_id status_code active response)a

    @primary_key false
    schema "user_routes" do
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
    end
  end
