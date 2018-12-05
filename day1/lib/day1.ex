defmodule Day1 do
  def go do
    {:ok, data} = File.read("lib/input.txt")
    data |> compute
  end

  def compute(data) do
    data
    |> String.split("\n")
    |> Enum.filter(fn x -> String.length(x) > 0 end)
    |> Enum.map(& String.to_integer &1)
    |> Enum.sum
  end
end
