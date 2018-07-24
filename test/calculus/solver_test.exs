defmodule Calculus.SolverTest do
  use ExUnit.Case, async: true

  test "Given a list of possible keys and a map, provide a list of undefined keys" do
    assert Calculus.Solver.free_keys([:a, :b, :c, :d], %{b: 5, c: 3}) == [:a, :d]
  end
end
