defmodule Backend.Factory do
  # NOTE These are taken directly from rushing.json, but it might be better to
  # generate random data, or maybe even use a property-based testing approach
  @rush_fixtures [
    %Backend.Rush{
      player: "Joe Banyard",
      team: "JAX",
      position: "RB",
      attempts: 2,
      attempts_per_game: 2.0,
      yards: 7,
      yards_per_attempt: 3.5,
      yards_per_game: 7.0,
      touchdowns: 0,
      longest: 7,
      first_downs: 0,
      first_down_percentage: 0.0,
      twenty_plus_yards: 0,
      forty_plus_yards: 0,
      fumbles: 0,
      longest_was_touchdown: false
    },
    %Backend.Rush{
      player: "Shaun Hill",
      team: "MIN",
      position: "QB",
      attempts: 5,
      attempts_per_game: 1.7,
      yards: 5,
      yards_per_attempt: 1.0,
      yards_per_game: 1.7,
      touchdowns: 0,
      longest: 9,
      first_downs: 0,
      first_down_percentage: 0.0,
      twenty_plus_yards: 0,
      forty_plus_yards: 0,
      fumbles: 0,
      longest_was_touchdown: true
    },
    %Backend.Rush{
      player: "Breshad Perriman",
      team: "BAL",
      position: "WR",
      attempts: 1,
      attempts_per_game: 0.1,
      yards: 2,
      yards_per_attempt: 2.0,
      yards_per_game: 0.1,
      touchdowns: 0,
      longest: 2,
      first_downs: 0,
      first_down_percentage: 0.0,
      twenty_plus_yards: 0,
      forty_plus_yards: 0,
      fumbles: 0,
      longest_was_touchdown: false
    }
  ]

  def build(:rush, num \\ 1), do: @rush_fixtures |> Stream.cycle() |> Enum.take(num)

  def insert(:rush, num \\ 1) do
    rushes = build(:rush, num)
    rushes |> Enum.each(&Backend.Repo.insert!/1)
    rushes
  end
end
