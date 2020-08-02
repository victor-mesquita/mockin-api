defmodule Mockin.Model.Role do
  use Ecto.Schema
  import Ecto.Changeset
  
  @required_fields ~w(name)a

  @roles %{ :admin => 2, :user => 1 }
  
  schema "role" do
    field :name, :string

    timestamps()
  end

  def roles() do 
    @roles
  end

  def changeset(role, attrs) do
    role
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
