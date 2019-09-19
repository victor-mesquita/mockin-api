defmodule Mockin.Model.Route do
    @moduledoc """
    The Route model.
    """

    use Ecto.Schema
    import Ecto.Changeset

    @required_fields ~w(path http_method)a

    schema "route" do
      field(:path, :string)
      field(:http_method, :string)
    end

    def changeset(user, attrs) do
      user
      |> cast(attrs, @required_fields)
      |> validate_required(@required_fields)
      |> unique_constraint(:path, name: :route_path_http_method_index)
    end
  end
