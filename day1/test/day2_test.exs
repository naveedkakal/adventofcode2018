defmodule Day2Test do
  use ExUnit.Case
  doctest Day2

  test "computes frequency" do
    {:ok, data} = File.read("test/test_input_2.txt")

    assert Day2.compute(data) == 10
  end
end
