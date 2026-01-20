defmodule GameOfLife do
  def draw(world) when is_binary(world) do
    world |> to_grid() |> draw()

    world
  end

  def draw(grid) when is_list(grid) do
    grid
    |> Enum.map(fn line -> Enum.join(line, "") end)
    |> Enum.each(fn line -> IO.puts(line) end)

    IO.puts(" ") # padding to split generations
    grid
  end

  def next(world) when is_binary(world) do
    world |> to_grid() |> next()
  end

  def next(grid) when is_list(grid) do
    grid
    |> Enum.with_index()
    |> Enum.map(fn {row, y} ->
      row
      |> Enum.with_index()
      |> Enum.map(fn {cell, x} ->
        Rules.survive_rule(grid, cell, {x, y})
      end)
    end)
  end

  def to_grid(world) do
    world
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn line ->
      line
      |> String.graphemes()
    end)
  end
end
