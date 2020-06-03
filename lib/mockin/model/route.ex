defmodule Mockin.Model.Route do
    @moduledoc """
    The Route model.
    """

    use Ecto.Schema
    import Ecto.Changeset

    @required_fields ~w(path http_method user_id status_code active response)a

    schema "route" do
      field(:path, :string)
      field(:status_code, :integer)
      field(:active, :boolean)
      field(:response, :string)
      field(:user_id, :integer)
      field(:http_method, :string)
    end

    def changeset(user, attrs) do
      user
      |> cast(attrs, @required_fields)
      |> validate_required(@required_fields)
      |> unique_constraint(:user_id, name: :user_route_msisdn_key)
      |> unique_constraint(:route_id, name: :user_route_pkey)
      |> foreign_key_constraint(:user_id)
      |> unique_constraint(:path, name: :route_path_http_method_user_id_index)
    end
  end
