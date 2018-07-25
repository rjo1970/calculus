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
    |> Stream.map(fn [a, b] -> {[a, b], !MapSet.member?(free, a) and MapSet.member?(free, b)} end)
    |> Stream.filter(fn {_k, m} -> m end)
    |> Stream.map(fn {k, true} -> k end)
    |> Enum.take(1)
    |> List.flatten()
  end

  defp all_variables(s_of_eq) do
    s_of_eq
    |> Map.keys()
    |> List.flatten()
    |> Enum.uniq()
  end

  def step([], problem, _s_of_eq) do
    problem
  end

  def step(step_key, problem, s_of_eq) do
    f = s_of_eq[step_key]
    [given, provides] = step_key

    solved = f.(problem[given])

    next_problem = Map.put(problem, provides, solved)
    next_key = next_step_key(next_problem, s_of_eq)

    step(next_key, next_problem, s_of_eq)
  end

  def solve(s_of_eq, problem) do
    expanded_eq = Calculus.expand(s_of_eq)
    next_key = next_step_key(problem, expanded_eq)
    step(next_key, problem, expanded_eq)
  end

  def solve(s_of_eq) do
    fn problem -> solve(s_of_eq, problem) end
  end
end
