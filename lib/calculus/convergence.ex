defmodule Calculus.Convergence do

  def converge(stream, epsilon) do
    stream
    |> framed_as_pairs()
    |> Stream.take(500)
    |> Stream.filter(fn(x) -> norm(x) < epsilon end)
    |> Enum.take(1)
    |> List.flatten()
    |> find_first()
  end

  defp framed_as_pairs(stream) do
    Stream.chunk_every(stream, 2,1,[])
  end

  def norm([a,b]) do
    abs(a - b)
  end

  defp find_first([]) do
    :does_not_converge
  end

  defp find_first([a, _b]) do
    a
  end

end
