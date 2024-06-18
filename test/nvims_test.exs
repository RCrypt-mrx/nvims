defmodule NvimsTest do
  use ExUnit.Case
  doctest Nvims

  test "greets the world" do
    assert Nvims.hello() == :world
  end
end
