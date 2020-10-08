defmodule BackendWeb.RushControllerTest do
  use BackendWeb.ConnCase

  test "returns a list of all rushes" do
    rushes = Backend.Factory.insert(:rush, 42)

    conn = build_conn()
    conn = get(conn, Routes.rush_path(conn, :index))

    assert conn |> json_response(200) == %{"rushes" => Jason.encode!(rushes)}
  end
end
