defmodule Calculus.Reverse do
  def reverse({[a,b], f}) do
    fz = Calculus.zero_function(f)
    reverse = fn(x) ->
      zero_fn = fz.(x)
      zero_prime = Calculus.derivative(zero_fn)

      zero_fn
      |> Calculus.find_zero(zero_prime)
      |> Calculus.converge()
    end

    {[b,a], reverse}
  end
end
