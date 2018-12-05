defmodule Day1Test do
  use ExUnit.Case
  doctest Day1

  test "computes frequency" do
    {:ok, data} = File.read("test/test_input.txt")

    assert Day1.compute(data) == 4
  end
end
