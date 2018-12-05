defmodule Day2 do
  def go do
    {:ok, data} = File.read("lib/input_2.txt")
    data |> compute
  end

  def compute(data) do
    data
    |> String.split("\n")
    |> Enum.filter(fn x -> String.length(x) > 0 end)
    |> Enum.map(& String.to_integer &1)
    |> Stream.cycle
    |> Enum.reduce_while({%{0 => true}, 0}, fn x, {seen_frequences, current_frequency} ->
      new_frequency = current_frequency + x
      IO.inspect(new_frequency, label: "Next is")
      if Map.has_key?(seen_frequences, new_frequency) do
        {:halt, new_frequency}
      else
        {:cont, {Map.put(seen_frequences, new_frequency, true), new_frequency}}
      end
    end)
  end
end
