defmodule Day2 do

  def go do
    {:ok, data} = File.read("lib/input_1.txt")
    compute(data)
  end

  def compute(data) do
    {twices, thrices} =
      data
      |> String.split("\n")
      |> Enum.map(fn x -> String.graphemes(x) end)
      |> Enum.reduce({0, 0}, fn x, {two_ct, three_ct} ->
        word_dat =
          Enum.reduce(x, %{}, fn y, acc2 ->
            Map.update(acc2, y, 1, fn cur -> cur + 1 end)
          end)
          |> Map.values()

        twice = if Enum.any?(word_dat, &(&1 == 2)), do: two_ct + 1, else: two_ct
        thrice = if Enum.any?(word_dat, &(&1 == 3)), do: three_ct + 1, else: three_ct
        {twice, thrice}
      end)

    twices * thrices
  end
end
