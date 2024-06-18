defmodule Nvims.Server.Router.Vswitch do
  use Plug.Router
  require Logger

  alias Nvims.Controller.Vswitch

  plug :match
  plug :dispatch

  get "/" do
    Logger.info("GET 200 #{__MODULE__}")
    response =
      if Map.has_key?(conn.params, "uuid") do
        Vswitch.get(conn.params["uuid"])
      else
        "Query parameter <uuid> is required"
      end

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(response))
  end

  post "/" do
    Logger.info("POST 200 #{__MODULE__}")

    body_params = [
      "name"
    ]

    response =
      if Enum.find_value(body_params, nil, fn param ->
          Map.has_key?(conn.body_params, param) == false
        end) do
        Vswitch.create(for param <- body_params do
          {param, conn.body_params[param]}
        end)
      else
        "Required JSON fields not defined: #{Enum.join(body_params, ", ")}"
      end

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(response))
  end

  put "/" do
    Logger.info("PUT 200 #{__MODULE__}")

    changeable_params = [
      "name"
    ]

    response =
      if Map.has_key?(conn.body_params, "uuid") do
        Vswitch.update(for param <- changeable_params do
          {param, conn.body_params[param]}
        end)
      else
        "Required JSON field not defined: uuid"
      end

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(response))
  end

  put "/connect" do
    Logger.info("PUT CONNECT 200 #{__MODULE__}")

    valid_params = [
      "uuid",
      "vmuuid"
    ]

    response =
      if Map.has_key?(conn.body_params, "uuid") do
        Vswitch.connect(for param <- valid_params do
          {param, conn.body_params[param]}
        end)
      else
        "Required JSON field not defined: uuid"
      end

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(response))
  end

  put "/disconnect" do
    Logger.info("PUT DISCONNECT 200 #{__MODULE__}")

    valid_params = [
      "uuid",
      "vmuuid"
    ]

    response =
      if Map.has_key?(conn.body_params, "uuid") do
        Vswitch.connect(for param <- valid_params do
          {param, conn.body_params[param]}
        end)
      else
        "Required JSON field not defined: uuid"
      end

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(response))
  end

  delete "/" do
    Logger.info("DELETE 200 #{__MODULE__}")

    response =
      if Map.has_key?(conn.body_params, "uuid") do
        Vswitch.delete(conn.body_params["uuid"])
      else
        "Required JSON field not defined: uuid"
      end

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(response))
  end

  match _, do: send_resp(conn, 404, "Path not found")
end
