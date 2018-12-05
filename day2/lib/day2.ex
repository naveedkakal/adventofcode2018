defmodule Day2 do

  def go do
    {:ok, data} = File.read("lib/input_1.txt")
    compute(data)
  end

  def go2 do
    {:ok, data} = File.read("lib/input_1.txt")
    find_similar(data)
  end

  def compute(data) do
    {twices, thrices} =
      data
      |> String.trim
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


  def find_similar(data) when is_binary(data) do
    data
    |> String.trim
    |> String.split("\n")
    |> find_similar
  end

  def find_similar([term | list] = data) when is_list(data) do
    term_graphenes = String.graphemes(term)
    # Find a result for this head term
    result = Enum.find_value(list, fn list_term ->
      list_term_graphenes = String.graphemes(list_term)
      matched = term_graphenes
      |> Enum.zip(list_term_graphenes)
      |> Enum.reduce("", fn {a, b}, acc ->
        if a == b do
          acc <> a
        else
          acc
        end
      end)
      if String.length(matched) == Enum.count(list_term_graphenes) - 1 do
        matched
      else
        false
      end
    end)

    # If it doesn't exist, ignore it for the rest of the evals
    # just look for the next items match
    result || find_similar(list)
  end


end
