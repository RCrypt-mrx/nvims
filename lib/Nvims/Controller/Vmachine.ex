defmodule Nvims.Controller.Vmachine do
  def get(uuid \\ nil) do

  end

  def create(%{
    "name" => name,
    "ram" => ram,
    "cpu" => cpu,
    "vdisks" => vdisks
  }) do

  end

  def update(%{
    "uuid" => uuid,
    "name" => name,
    "ram" => ram,
    "cpu" => cpu,
    "vdisks" => vdisks
  }) do

  end

  def delete(%{"uuid" => uuid}) do

  end
end
