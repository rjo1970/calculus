defmodule Calculus do
  defdelegate find_zero(f, f_prime), to: Calculus.Newton, as: :newton_iterator
  defdelegate find_zero(f, f_prime, start), to: Calculus.Newton, as: :newton_iterator
  defdelegate derivative(f, delta), to: Calculus.Richardson, as: :richardson
  defdelegate converge(iterator, epsilon), to: Calculus.Convergence
end
