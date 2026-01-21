defmodule Normalize do
  def parse(world) when is_binary(world) do
    world |> to_grid()
  end
  def parse(world) when is_list(world), do: world

  defp to_grid(world) do
    world
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn line ->
      String.graphemes(line)
    end)
  end
end
