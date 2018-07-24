defmodule Calculus.ConvergenceTest do
  use ExUnit.Case, async: true

  @subject Calculus.Convergence

  test "finds the first element where subsequent sequence values differ by less than epsilon" do
    fx = fn x -> :math.pow(x, 2) end
    dx = Calculus.derivative(fx, 0.01)
    newton_iterator = Calculus.find_zero(fx, dx, 1)

    result = @subject.converge(newton_iterator, 0.01)

    assert_in_delta(result, 0.015625, 0.01)
  end

  test "if there is no suitable pair with an epsilon, bail out" do
    result = Stream.cycle([1, 5]) |> @subject.converge(0.01)
    assert result == :does_not_converge
  end
end
