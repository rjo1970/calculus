defmodule Calculus.Convergence do
  def converge(stream, epsilon) do
    stream
    |> framed_as_pairs()
    |> Stream.take(500)
    |> Stream.filter(fn x -> norm(x) < epsilon end)
    |> Enum.take(1)
    |> List.flatten()
    |> find()
  end

  defp framed_as_pairs(stream) do
    Stream.chunk_every(stream, 2, 1, [])
  end

  def norm([a, b]) do
    abs(a - b)
  end

  def norm([x]) do
    x
  end

  defp find([]) do
    :does_not_converge
  end

  defp find([_a, b]) do
    b
  end
end
