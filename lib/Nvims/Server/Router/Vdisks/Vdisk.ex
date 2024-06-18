defmodule Nvims.Server.Router.Vdisk do
  use Plug.Router
  require Logger

  alias Nvims.Controller.Vdisk

  plug :match
  plug :dispatch

  get "/" do
    Logger.info("GET 200 #{__MODULE__}")
    response =
      if Map.has_key?(conn.params, "uuid") do
        Vdisk.get(conn.params["uuid"])
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
      "name",
      "maxsize"
    ]

    response =
      if Enum.find_value(body_params, nil, fn param ->
          Map.has_key?(conn.body_params, param) == false
        end) do
        Vdisk.create(for param <- body_params do
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
        Vdisk.update(for param <- changeable_params do
          {param, conn.body_params[param]}
        end)
      else
        "Required JSON field not defined: uuid"
      end

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(response))
  end

  put "/extend" do
    Logger.info("PUT EXTEND 200 #{__MODULE__}")

    valid_params = [
      "uuid",
      "maxsize"
    ]

    response =
      if Map.has_key?(conn.body_params, "uuid") do
        Vdisk.extend(for param <- valid_params do
          {param, conn.body_params[param]}
        end)
      else
        "Required JSON field not defined: uuid"
      end

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(response))
  end

  put "/clone" do
    Logger.info("PUT CLONE 200 #{__MODULE__}")

    valid_params = [
      "uuid",
      "name"
    ]

    response =
      if Map.has_key?(conn.body_params, "uuid") do
        Vdisk.clone(for param <- valid_params do
          {param, conn.body_params[param]}
        end)
      else
        "Required JSON field not defined: uuid"
      end

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(response))
  end

  put "/save" do
    Logger.info("PUT SAVE 200 #{__MODULE__}")

    valid_params = [
      "uuid",
      "save_name"
    ]

    response =
      if Map.has_key?(conn.body_params, "uuid") do
        Vdisk.save(for param <- valid_params do
          {param, conn.body_params[param]}
        end)
      else
        "Required JSON field not defined: uuid"
      end

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(response))
  end

  put "/rollback" do
    Logger.info("PUT ROLLBACK 200 #{__MODULE__}")

    valid_params = [
      "uuid",
      "save_uuid"
    ]

    response =
      if Map.has_key?(conn.body_params, "uuid") do
        Vdisk.rollback(for param <- valid_params do
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
        Vdisk.delete(conn.body_params["uuid"])
      else
        "Required JSON field not defined: uuid"
      end

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(response))
  end

  match _, do: send_resp(conn, 404, "Path not found")
end
