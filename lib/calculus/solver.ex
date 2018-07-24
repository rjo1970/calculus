defmodule Calculus.Solver do
  def free_keys(list, map) do
    keys =
      map
      |> Map.keys()
      |> MapSet.new()

    list
    |> MapSet.new()
    |> MapSet.difference(keys)
    |> MapSet.to_list
  end
end
