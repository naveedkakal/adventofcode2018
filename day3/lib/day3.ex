defmodule Day3 do
  def best_claim_id(data) do
    claims =
      data
      |> String.split("\n", trim: true)
      |> Claim.parse()

    board = build_board(claims)
    single_squares =
      board
      |> Enum.filter(fn {_k, v} -> Enum.count(v) == 1 end)
      |> Enum.map(fn {sq, _z} -> sq end)
      |> MapSet.new

    best_claim =
      claims
      |> Enum.find(fn claim ->
        ms = MapSet.new(claim.squares)
        MapSet.equal?(ms, MapSet.intersection(ms, single_squares))
      end)

    best_claim.id
  end

  def popular_squares(data) do
    data
    |> String.split("\n", trim: true)
    |> Claim.parse()
    |> build_board
    |> Enum.count(fn {_k, v} -> Enum.count(v) >= 2 end)
  end

  defp build_board(claims) do
    claims
    |> Enum.reduce(%{}, fn claim, board ->
      Enum.reduce(claim.squares, board, fn sq, board ->
        Map.update(board, sq, [claim.id], &[claim.id | &1])
      end)
    end)
  end
end
