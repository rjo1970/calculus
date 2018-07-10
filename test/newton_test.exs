defmodule Calculus.NewtonTest do
  use ExUnit.Case, async: true

  test "Creates a Newton iterator starting at 0.1" do
    fx = fn(x) -> x * x * x + 5 end
    dx = Calculus.derivative(fx, 0.1)

    newton = Calculus.Newton.newton_iterator(fx, dx, 1)

    result =
    newton
    |>Enum.take(7)
    |>Enum.drop(6)
    |>hd()
    assert_in_delta(result, -1.709975946676697, 0.000001)
  end

end
