defmodule Calculus.Newton do

  @moduledoc """
  Find the zero given a function and its derivative.
  """

  def newton_iterator(f, f_prime) do
    newton_iterator(f, f_prime, 0)
  end

  def newton_iterator(f, f_prime, start) do
    Stream.unfold(start, fn (x) ->
      result = x - (f.(x) / f_prime.(x))
      {result, result}
    end)
  end

end
