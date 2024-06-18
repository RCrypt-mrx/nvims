defmodule Nvims.Application do
  use Application

  def start(_type, _args) do
    Supervisor.start_link(
      [
        {Nvims.Server.Endpoint, []} # HTTP API service
      ],
      [strategy: :one_for_one, name: Nvims.Supervisor]
    )
  end
end
