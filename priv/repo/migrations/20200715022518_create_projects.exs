defmodule Mockin.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:project) do
      add :name, :string, null: false
      add :description, :string, null: false

      timestamps()
    end

    create table(:project_member) do
      add(:project_id, references(:project))
      add(:user_id, references(:user))
      add :default, :boolean, null: false

      timestamps()
    end

    alter table(:mock_user) do
      add(:project_id, references(:project))
    end


    create unique_index(:project_member, [:project_id, :user_id])
    create unique_index(:mock_user, [:project_id, :msisdn])
  end
end
