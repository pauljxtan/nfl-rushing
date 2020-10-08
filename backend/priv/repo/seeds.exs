json = File.read!("priv/repo/rushing.json") |> Jason.decode!()

Backend.Repo.delete_all(Backend.Rush)
json |> Enum.each(fn row -> Backend.Rush.from_csv(row) |> Backend.Repo.insert!() end)
