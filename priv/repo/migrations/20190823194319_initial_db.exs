defmodule Mockin.Repo.Migrations.InitialDb do
  use Ecto.Migration

  def change do
    create table(:segment) do
      add(:name, :string, null: false)
    end

    create table(:sub_segment) do
      add(:name, :string, null: false)
      add(:segment_id, references(:segment))
    end

    create table(:user) do
      add(:msisdn, :string, null: false)
      add(:name, :string)
      add(:segment_id, references(:segment))
      add(:subsegment_id, references(:sub_segment))

      timestamps(inserted_at: :created_at)
    end

    create table(:route) do
      add(:path, :string, null: false)
      add(:httpMethod, :string, null: false)
    end

    create table(:user_routes, primary_key: false) do
      add(:statusCode, :integer, null: false)
      add(:active, :boolean, null: false)
      add(:response, :string)

      add(:user_id, references(:user), primary_key: true)
      add(:route_id, references(:route), primary_key: true)
    end

    create(unique_index(:route, [:path]))
    create(unique_index(:user, [:msisdn]))
  end
end
