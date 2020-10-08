defmodule BackendWeb.RushController do
  use BackendWeb, :controller

  def index(conn, _params),
    do: conn |> render("index.json", rushes: Backend.Repo.all(Backend.Rush))
end
