defmodule Nvims.Server.Router.Vdisks do
  use Plug.Router
  require Logger

  alias Nvims.Controller.Vdisk

  plug :match
  plug :dispatch

  get "/" do
    Logger.info("GET 200 #{__MODULE__}")
    response = Vdisk.get()

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(response))
  end

  match _, do: send_resp(conn, 404, "Path not found")
end
