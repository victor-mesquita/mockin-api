defmodule Mockin.Repo.Migrations.AddProjectIdToRoute do
  use Ecto.Migration

  def change do

    alter table(:route) do
      add(:project_id, references(:project))
    end

    create unique_index(:route, [:project_id, :mock_user_id, :id])
  end
end
