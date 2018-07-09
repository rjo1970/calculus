defmodule Calculus do
  defdelegate richardson(f, delta), to: Calculus.Richardson
end
