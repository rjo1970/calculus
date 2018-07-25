defmodule Calculus.Solver do

  def free_keys(list, map) do
    keys =
      map
      |> Map.keys()
      |> MapSet.new()

    list
    |> MapSet.new()
    |> MapSet.difference(keys)
  end

  def next_step_key(problem, system_of_equations) do
    keys = Map.keys(system_of_equations)

    free =
      system_of_equations
    |> all_variables()
    |> free_keys(problem)

    keys
    |> Stream.map(fn([a,b]) -> {[a,b], !MapSet.member?(free, a) and MapSet.member?(free, b)} end)
    |> Stream.filter(fn({_k, m}) -> m end)
    |> Stream.map(fn({k, true}) -> k end)
    |> Enum.take(1)
    |> List.flatten()
  end

  defp all_variables(s_of_eq) do
    s_of_eq
    |> Map.keys()
    |> List.flatten()
    |> Enum.uniq()
  end

  def step([], problem, _s_of_e) do
    problem
  end

  def step(step_key, problem, s_of_e) do
    f = s_of_e[step_key]
    [a,b] = step_key

    fa = f.(problem[a])

    next_problem = Map.put(problem, b, fa)
    next_key = next_step_key(next_problem, s_of_e)

    step(next_key, next_problem, s_of_e)
  end
end
