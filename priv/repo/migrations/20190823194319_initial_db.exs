defmodule Mockin.Repo.Migrations.InitialDb do
  use Ecto.Migration

  def change do
    create table(:user) do
      timestamps(inserted_at: :created_at)
    end

    create table(:route) do
      add(:path, :string, null: false)
    end

    create table(:user_routes, primary_key: false) do
      add(:statusCode, :integer, null: false)
      add(:httpMethod, :string, null: false)
      add(:active, :boolean, null: false)
      add(:response, :string)

      add(:user_id, references(:user), primary_key: true)
      add(:route_id, references(:route), primary_key: true)
    end

    create(unique_index(:route, [:path]))
  end
end
