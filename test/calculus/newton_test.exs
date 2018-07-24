defmodule Calculus.NewtonTest do
  use ExUnit.Case, async: true

  test "Creates a Newton iterator starting at 0.1" do
    fx = fn x -> x * x * x + 5 end
    dx = Calculus.derivative(fx, 0.1)

    newton = Calculus.Newton.newton_iterator(fx, dx, 1)

    result =
      newton
      |> Enum.take(7)
      |> Enum.drop(6)
      |> hd()

    assert_in_delta(result, -1.709975946676697, 0.000001)
  end

  test "Creates a zero function based on a given function" do
    epsilon = 0.000001
    f_to_c = fn f -> (f - 32) / 1.8 end

    zero_fn_at_neg_40 = Calculus.Newton.zero_function(f_to_c).(-40)

    result =
      Calculus.find_zero(zero_fn_at_neg_40, Calculus.derivative(zero_fn_at_neg_40))
      |> Calculus.converge(epsilon)

    assert_in_delta(result, -40.0, epsilon)
  end
end
