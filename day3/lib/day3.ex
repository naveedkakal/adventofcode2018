defmodule Day3 do
  def popular_squares(data) do
    data
    |> String.trim
    |> String.split("\n")
    |> Enum.reduce(%{}, fn elf_square, acc ->
      build_squares(elf_square)
      |> Enum.reduce(acc, fn z, acc2 ->
        Map.update(acc2, z, 1, fn cv -> cv + 1 end)
      end)
    end)
    |> Enum.filter(fn {_, v} -> v >= 2 end)
    |> Enum.count
  end

  # Pretty sure this parsing should be done via regex
  # Still suck at those - doing string splits trims /shrug
  def build_squares(data \\ "#1 @ 1,3: 4x4" ) do
    [_elf_id, _sym, front_raw, back_raw] = String.split(data)
    [x0, y0] = front_raw |> String.trim(":") |> String.split(",")
    [dx, dy] = back_raw |> String.split("x")
    x0 = String.to_integer(x0)
    dx = String.to_integer(dx)
    x_range = x0..(x0 + dx - 1)

    y0 = String.to_integer(y0)
    dy = String.to_integer(dy)
    y_range = y0..(y0 + dy - 1)

    Enum.reduce(x_range, [], fn x, acc ->
      acc ++ Enum.map(y_range, fn y -> {x, y} end)
    end)
  end
end
