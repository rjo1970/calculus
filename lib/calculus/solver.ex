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
    |> Stream.map(fn [a, b] -> {[a, b], is_matching?(free, [a, b])} end)
    |> Stream.filter(fn {_k, m} -> m end)
    |> Stream.map(fn {k, true} -> k end)
    |> Enum.take(1)
    |> List.flatten()
  end

  defp is_matching?(free, [a,b]) do
    if is_list(a) do
      with free_members <- a |> MapSet.new() |> MapSet.intersection(free),
           complete <- free_members == MapSet.new()
           do
              complete and MapSet.member?(free, b)
           end
    else
      !MapSet.member?(free, a) and MapSet.member?(free, b)
    end
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

  def step([given, provides] = step_key, problem, s_of_eq) do
    f = s_of_eq[step_key]

    solved = f.(problem[given])

    next_problem = Map.put(problem, provides, solved)
    next_key = next_step_key(next_problem, s_of_eq)

    step(next_key, next_problem, s_of_eq)
  end

  def step(step_key, problem, s_of_eq) do
    given = step_key |> Enum.take(length(step_key) - 1)
    provides = step_key |> Enum.drop(length(step_key) - 1) |> Enum.take(1) |> hd()
    key = [given, provides]
    f = s_of_eq[key]
    args = given |> Enum.map(fn(x) -> problem[x] end)
    solved = apply(f, args)

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
