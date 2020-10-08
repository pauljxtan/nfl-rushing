defmodule Backend.Repo.Migrations.CreateRushes do
  use Ecto.Migration

  def change do
    create table(:rushes) do
      add :player, :string
      add :team, :string
      add :position, :string
      add :attempts_per_game, :float
      add :attempts, :integer
      add :yards, :integer
      add :yards_per_attempt, :float
      add :yards_per_game, :float
      add :touchdowns, :integer
      add :longest, :integer
      add :first_downs, :integer
      add :first_down_percentage, :float
      add :twenty_plus_yards, :integer
      add :forty_plus_yards, :integer
      add :fumbles, :integer

      add :longest_was_touchdown, :boolean

      timestamps()
    end
  end
end
