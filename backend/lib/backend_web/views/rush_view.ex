defmodule BackendWeb.RushView do
  use BackendWeb, :view

  def render("index.json", %{rushes: rushes}), do: %{rushes: Jason.encode!(rushes)}

  defp postprocess(rushes), do: rushes |> Enum.map(&postprocess/1)

  defp postprocess(%Backend.Rush{longest_was_touchdown: true} = rush),
    do: rush |> Map.update!(:longest, fn v -> v <> "S" end)

  defp postprocess(rush), do: rush
end
