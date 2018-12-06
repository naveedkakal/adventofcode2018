defmodule ClaimTest do
  use ExUnit.Case
  doctest Claim

  test "parses a claim" do
    claim = Claim.parse("#1 @ 1,3: 2x2")
    %Claim{id: id, squares: squares} = claim
    assert(id == 1)
    assert(squares == MapSet.new([{1, 3}, {1, 4}, {2, 3}, {2, 4}]))
  end
end
