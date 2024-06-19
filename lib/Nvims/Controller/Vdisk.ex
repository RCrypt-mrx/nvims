defmodule Nvims.Controller.Vdisk do
  def get(uuid \\ nil) do

  end

  def get_saves(uuid) do

  end

  def create(%{
    "name" => name,
    "maxsize" => maxsize
  }) do

  end

  def update(%{
    "uuid" => uuid,
    "name" => name
  }) do

  end

  def extend(%{
    "uuid" => uuid,
    "maxsize" => maxsize
  }) do

  end

  def clone(%{
    "uuid" => uuid,
    "name" => name
  }) do

  end

  def save(%{
    "uuid" => uuid,
    "save_name" => save_name
  }) do

  end

  def rollback(%{
    "uuid" => uuid,
    "save_uuid" => save_uuid
  }) do

  end

  def delete(%{"uuid" => uuid}) do

  end
end
