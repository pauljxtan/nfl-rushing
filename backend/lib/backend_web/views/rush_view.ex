defmodule BackendWeb.RushView do
  use BackendWeb, :view

  def render("index.json", %{rushes: rushes}), do: %{rushes: Jason.encode!(rushes)}
end
