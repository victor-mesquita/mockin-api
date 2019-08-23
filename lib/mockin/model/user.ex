defmodule Mockin.Model.User do
  @moduledoc """
  The User model.
  """

  use Ecto.Schema

  schema "user" do
    has_many(:user_routes, Mockin.Model.UserRoutes)

    timestamps(inserted_at: :created_at)
  end
end
