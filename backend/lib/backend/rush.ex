defmodule Backend.Rush do
  use Ecto.Schema
  import Ecto.Changeset

  @doc """
  A mapping of csv columns to database columns.
  """
  @csv_to_db %{
    "Player" => :player,
    "Team" => :team,
    "Pos" => :position,
    "Att/G" => :attempts_per_game,
    "Att" => :attempts,
    "Yds" => :yards,
    "Avg" => :yards_per_attempt,
    "Yds/G" => :yards_per_game,
    "TD" => :touchdowns,
    "Lng" => :longest,
    "1st" => :first_downs,
    "1st%" => :first_down_percentage,
    "20+" => :twenty_plus_yards,
    "40+" => :forty_plus_yards,
    "FUM" => :fumbles
  }

  @derive {Jason.Encoder, only: Map.values(@csv_to_db) ++ [:longest_was_touchdown]}
  schema "rushes" do
    field :player, :string
    field :team, :string
    field :position, :string
    field :attempts_per_game, :float
    field :attempts, :integer
    field :yards, :integer
    field :yards_per_attempt, :float
    field :yards_per_game, :float
    field :touchdowns, :integer
    field :longest, :integer
    field :first_downs, :integer
    field :first_down_percentage, :float
    field :twenty_plus_yards, :integer
    field :forty_plus_yards, :integer
    field :fumbles, :integer

    # An auxiliary field to indicate if a touchdown occurred on the longest rush
    field :longest_was_touchdown, :boolean

    timestamps()
  end

  @doc false
  def changeset(rush, attrs) do
    rush
    |> cast(attrs, Map.values(@csv_to_db) ++ [:longest_was_touchdown])
    |> validate_required(Map.values(@csv_to_db) ++ [:longest_was_touchdown])
  end

  @doc """
  Converts a row in the expected csv input into a corresponding changeset.
  """
  def from_csv(row) do
    map =
      row
      |> Enum.map(fn {k, v} ->
        {
          @csv_to_db[k],
          # Remove comma delimiters in large integers
          if(is_binary(v) and String.match?(v, ~r/^\d{1,3}(,\d{3})*$/),
            do: String.replace(v, ",", ""),
            else: v
          )
        }
      end)
      |> Enum.into(%{})

    # Check if the longest rush resulted in a touchdown
    longest_was_touchdown = is_binary(map[:longest]) and String.contains?(map[:longest], "T")
    map = map |> Map.put(:longest_was_touchdown, longest_was_touchdown)

    # Now remove the "T" if present
    map =
      if longest_was_touchdown,
        do: map |> Map.update!(:longest, fn v -> v |> String.replace("T", "") end),
        else: map

    changeset(%Backend.Rush{}, map)
  end
end
