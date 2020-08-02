defmodule Mockin.Repo.Migrations.CreateNewUserTable do
  use Ecto.Migration

  def change do

    create table(:role) do
      add :name, :string, null: false

      timestamps()
    end

    create table(:feature) do
      add :name, :string, null: false
      add :active, :boolean, null: false

      timestamps()
    end

    create table(:permission, primary_key: false) do
      add(:role_id, references(:role), primary_key: true)
      add(:feature_id, references(:feature), primary_key: true)

      timestamps()
    end
    
    create table(:user) do
      add :email, :string, null: false
      add :name, :string, null: false
      add :password_hash, :string

      add(:role_id, references(:role))

      timestamps()
    end


    create unique_index(:user, [:email])
  end
end
