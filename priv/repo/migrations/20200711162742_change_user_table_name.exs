defmodule Mockin.Repo.Migrations.ChangeUserTableName do
  use Ecto.Migration

  use Ecto.Migration

  def change do
    drop(unique_index(:route, [:path, :http_method, :user_id], name: :route_path_http_method_user_id_index))
    drop(unique_index(:user, [:msisdn]))

    rename table(:user), to: table(:mock_user)

    rename table(:route), :user_id, to: :mock_user_id

    alter table(:route) do
      modify :mock_user_id, references(:mock_user)
    end

    create(unique_index(:route, [:path, :http_method, :mock_user_id], name: :route_path_http_method_mock_user_id_index))
  end
end
