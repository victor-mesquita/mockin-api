defmodule Mockin.Model.UserRoutes do
    @moduledoc """
    The User Routes model.
    """

    use Ecto.Schema
    import Ecto.Changeset
    alias Mockin.Model.User
    alias Mockin.Model.Route

    @required_fields ~w(user_id route_id id statusCode httpMethod active response)a

    schema "user_routes" do
      field(:statusCode, :integer)
      field(:httpMethod, :string)
      field(:active, :boolean)
      field(:response, :string)

      belongs_to(:user, User, foreign_key: :user_id)
      belongs_to(:route, Route, foreign_key: :route_id)
      # timestamps(inserted_at: :created_at)
    end

    def changeset(user, attrs) do
      user
      |> cast(attrs, @required_fields)
      |> validate_required(@required_fields)
      |> unique_constraint(:user_id, name: :user_route_msisdn_key)
      |> unique_constraint(:route_id, name: :user_route_pkey)
    end
  end
