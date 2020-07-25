defmodule Mockin.Repo.Migrations.AddPowEmailConfirmationToUsers do
  use Ecto.Migration

  def change do
    alter table(:user) do
      add :email_confirmation_token, :string
      add :email_confirmed_at, :utc_datetime
      add :unconfirmed_email, :string
    end

    create unique_index(:user, [:email_confirmation_token])
  end
end
