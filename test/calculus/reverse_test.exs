defmodule Calculus.ReverseTest do
  use ExUnit.Case, async: true

  test "Given input and output fields and a function, find the reverse function" do
    f_to_c = fn f -> (f - 32) / 1.8 end
    start = {[:f, :c], f_to_c}

    finish = Calculus.Reverse.reverse(start)

    assert elem(finish, 0) == [:c, :f]
    assert_in_delta(elem(finish, 1).(100), 212.0, 0.01)
  end

  test "can exapand a system of equations" do
    sys_of_eq = [
      {[:f, :c], fn f -> (f - 32) / 1.8 end},
      {[:c, :k], fn c -> c + 273.15 end}
    ]

    result = Calculus.Reverse.expand(sys_of_eq)

    assert_in_delta(result[[:c, :f]].(100), 212.0, 0.01)
    assert_in_delta(result[[:k, :c]].(273.15), 0.0, 0.01)
  end
end
