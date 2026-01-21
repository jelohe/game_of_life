defmodule GameOfLife do
  def normalize(world) when is_binary(world) do
    world |> to_grid()
  end
  def normalize(world) when is_list(world), do: world

  def draw(world) do
    world
    |> normalize()
    |> Enum.map(fn line -> Enum.join(line, "") end)
    |> Enum.each(fn line -> IO.puts(line) end)

    IO.puts(" ")
  end

  def next(world) do
    grid = normalize(world)
    grid
    |> normalize()
    |> Enum.with_index()
    |> Enum.map(fn {row, y} ->
      row
      |> Enum.with_index()
      |> Enum.map(fn {cell, x} ->
        Rules.apply_all(grid, cell, {x, y})
      end)
    end)
  end

  def to_grid(world) do
    world
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn line ->
      String.graphemes(line)
    end)
  end
end
