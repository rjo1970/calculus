defmodule CalculusTest do
  use ExUnit.Case
  doctest Calculus

  test "richardson derivative gives a generator function that can be called for an x to get a derivative estimate at that point" do
    result = Calculus.richardson(fn x -> 2 * x * x + 3 * x + 2 end, 0.0001).(3)
    assert_in_delta(result, 15.0, 0.0001)
  end
end
