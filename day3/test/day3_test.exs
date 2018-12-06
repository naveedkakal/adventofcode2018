defmodule Day3Test do
  use ExUnit.Case
  doctest Day3

  test "finds popular squares" do
    {:ok, data} = File.read("test/test_input_1.txt")

    assert Day3.popular_squares(data) == 4
  end

  test "finds unshared elf_id" do
    {:ok, data} = File.read("test/test_input_1.txt")

    assert Day3.best_claim_id(data) == 3
  end
end
