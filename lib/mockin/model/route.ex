defmodule Mockin.Model.Route do
    @moduledoc """
    The Route model.
    """

    use Ecto.Schema
    import Ecto.Changeset

    @required_fields ~w(path http_method mock_user_id status_code active response description)a

    schema "route" do
      field(:path, :string)
      field(:description, :string)
      field(:status_code, :integer)
      field(:active, :boolean)
      field(:response, :string)
      field(:mock_user_id, :integer)
      field(:http_method, :string)

      timestamps(inserted_at: :created_at)
    end

    def changeset(user, attrs) do
      user
      |> cast(attrs, @required_fields)
      |> validate_required(@required_fields)
      |> unique_constraint(:mock_user_id, name: :mock_user_route_msisdn_key)
      |> unique_constraint(:route_id, name: :user_route_pkey)
      |> foreign_key_constraint(:mock_user_id)
      |> unique_constraint(:path, name: :route_path_http_method_mock_user_id_index)
    end
  end
