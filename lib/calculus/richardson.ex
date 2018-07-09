defmodule Calculus.Richardson do
  @moduledoc """
    Stolen shamelessly from https://github.com/francoisdevlin/Full-Disclojure/blob/master/src/episode_012/episode_012.clj

    Creates a function that computes the derivative using a Richardson interpolation.
  """

  def richardson(f, delta) do
    fn x ->
      with samples <-
             [-2, -1, 1, 2]
             |> Enum.map(&f.(x + delta * &1)),
           products <-
             [1, -8, 8, -1]
             |> Enum.zip(samples)
             |> Enum.map(fn {a, b} -> a * b end),
           sum <-
             products
             |> Enum.sum() do
        sum / (12 * delta)
      end
    end
  end
end
