defmodule Day3 do
  def best_claim_id(data) do
    claims =
      data
      |> String.split("\n", trim: true)
      |> Claim.parse()

    board = build_board(claims)

    best_claim =
      Enum.find(claims, fn claim ->
        Enum.filter(board, fn {_sq, cl_ids} ->
          Enum.member?(cl_ids, claim.id)
        end)
        |> Enum.all?(fn {_sq, cl_ids} -> Enum.count(cl_ids) == 1 end)
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
