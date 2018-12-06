defmodule Claim do
  defstruct [:id, :squares]

  # Pretty sure this parsing should be done via regex
  # Still suck at those - doing string splits trims /shrug
  def parse(claim_string) when is_binary(claim_string) do
    [claim_id, _sym, front_raw, back_raw] = String.split(claim_string)
    [x0, y0] = front_raw |> String.trim(":") |> String.split(",")
    [dx, dy] = back_raw |> String.split("x")
    x0 = String.to_integer(x0)
    dx = String.to_integer(dx)
    x_range = x0..(x0 + dx - 1)

    y0 = String.to_integer(y0)
    dy = String.to_integer(dy)
    y_range = y0..(y0 + dy - 1)

    boxes =
      Enum.reduce(x_range, [], fn x, acc ->
        acc ++ Enum.map(y_range, fn y -> {x, y} end)
      end)

    %Claim{
      id: String.trim(claim_id, "#") |> String.to_integer(),
      squares: MapSet.new(boxes)
    }
  end

  def parse(list) when is_list(list) do
    Enum.map(list, &Claim.parse(&1))
  end
end
