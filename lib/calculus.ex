defmodule Calculus do
  @epsilon 0.000001

  defdelegate find_zero(f, f_prime, start \\ @epsilon), to: Calculus.Newton, as: :newton_iterator
  defdelegate derivative(f, delta \\ @epsilon), to: Calculus.Richardson, as: :richardson
  defdelegate converge(iterator, epsilon \\ 0.0000000000001), to: Calculus.Convergence
  defdelegate zero_function(f), to: Calculus.Newton
  defdelegate reverse(tuple), to: Calculus.Reverse
end
