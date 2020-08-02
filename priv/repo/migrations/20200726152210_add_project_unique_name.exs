defmodule Mockin.Repo.Migrations.AddProjectUniqueName do
  use Ecto.Migration

  def change do
    alter table(:project) do
      add :unique_name, :string
    end

    create unique_index(:project, [:unique_name])
  end
end
