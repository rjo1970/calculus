defmodule Calculus.ReverseTest do
  use ExUnit.Case, async: true

  test "Given a function and its input and output values, find the reverse function" do
    f_to_c = fn(f) -> (f - 32) / 1.8 end
    start = {[:f, :c], f_to_c}

    finish = Calculus.Reverse.reverse(start)

    assert elem(finish,0) == [:c, :f]
    assert_in_delta(elem(finish, 1).(100), 212.0, 0.001)
  end
end
