defmodule Nvims.Controller.Infrastructure do
  def get(uuid \\ nil) do

  end

  def create(%{
    "name" => name,
    "description" => description,
    "schema" => schema
  }) do

  end

  def update(%{
    "uuid" => uuid,
    "name" => name,
    "description" => description,
    "schema" => schema
  }) do

  end

  def sync(%{"uuid" => uuid}) do

  end

  def async(%{"uuid" => uuid}) do

  end

  def close(%{"uuid" => uuid}) do

  end

  def delete(%{"uuid" => uuid}) do

  end
end
