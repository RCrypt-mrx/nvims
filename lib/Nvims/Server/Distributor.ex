defmodule Nvims.Server.Distributor do
  use Plug.Router

  plug :match
  plug :dispatch

  forward "/v0", to: Nvims.Server.Router.Api

  match _, do: send_resp(conn, 404, "Path not found")
end
