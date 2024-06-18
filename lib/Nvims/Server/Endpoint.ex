defmodule Nvims.Server.Endpoint do
  use Plug.Router
  require Logger

  plug Nvims.Server.Policy
  plug :match
  plug Plug.Parsers,
    parsers: [:urlencoded, :json],
    pass: ["application/json"],
    json_decoder: Poison
  plug :dispatch

  forward "/api", to: Nvims.Server.Distributor

  match _, do: send_resp(conn, 404, "Path not found")

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]}
    }
  end

  def start_link(_opts) do
    Logger.info("API ready")
    Nvims.Controller.Main.load()
    Plug.Cowboy.http(__MODULE__, [], port: 4040)
  end
end
