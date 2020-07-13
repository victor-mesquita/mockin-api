defmodule Mockin.Repo.Migrations.ExpandMaxLengthJson do
  use Ecto.Migration

  def up do
    alter table(:route) do
      modify :response, :string, size: 4000
    end
  end

  def down do
    alter table(:route) do
      modify :response, :string, size: 255
    end
  end

end
