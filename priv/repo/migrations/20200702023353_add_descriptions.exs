defmodule Mockin.Repo.Migrations.AddDescriptions do
  use Ecto.Migration

  def up do
    alter table(:user) do
      add(:description, :string, size: 60)
    end

    alter table(:route) do
      add(:description, :string, size: 60)

      timestamps(inserted_at: :created_at)
    end
  end

  def down do
    alter table(:user) do
      remove(:description)
    end

    alter table(:route) do
      remove(:description)
      remove(:created_at)
      remove(:updated_at)
    end
  end
end
