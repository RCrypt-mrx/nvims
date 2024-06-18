defmodule Nvims.Server.Router.Api do
  use Plug.Router

  alias Nvims.Server.Router

  plug :match
  plug :dispatch

  forward "/vmachine", to: Router.Vmachine
  forward "/vmachines", to: Router.Vmachines

  forward "/vswitch", to: Router.Vswitch
  forward "/vswitches", to: Router.Vswitches

  forward "/vdisk", to: Router.Vdisk
  forward "/vdisks", to: Router.Vdisks

  forward "/infrastructure", to: Router.Infrastructure
  forward "/infrastructures", to: Router.Infrastructures

  match _, do: send_resp(conn, 404, "Path not found")
end
