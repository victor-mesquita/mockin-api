defmodule Mockin.Repo.Migrations.InitialDb do
  use Ecto.Migration

  def change do
    create table(:user) do
      add(:msisdn, :string, null: false)
      add(:name, :string)

      timestamps(inserted_at: :created_at)
    end

    create table(:route) do
      add(:path, :string, null: false)
      add(:http_method, :string, null: false)
      add(:status_code, :integer, null: false)
      add(:active, :boolean, null: false)
      add(:response, :string)


      add(:user_id, references(:user), primary_key: true)
    end

    # create table(:route_details) do
    #   add(:status_code, :integer, null: false)
    #   add(:active, :boolean, null: false)
    #   add(:response, :string)

    #   add(:user_id, references(:user), primary_key: true)
    #   add(:route_id, references(:route), primary_key: true)
    # end

    create(unique_index(:route, [:path, :http_method, :user_id], name: :route_path_http_method_user_id_index))
    create(unique_index(:user, [:msisdn]))
  end
end
