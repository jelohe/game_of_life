defmodule GameOfLife do
  def iterate(world, times) do
    next_iteration(world, times)
  end

  defp next_iteration(world, i) when i > 0 do
    draw(world)
    next_iteration(next(world), i - 1)
  end

  defp next_iteration(_, i) when i == 0 do
  end

  def draw(world) when is_binary(world) do
    world |> to_grid() |> draw()

    world
  end

  def draw(grid) when is_list(grid) do
    grid
    |> Enum.map(fn line -> Enum.join(line, "") end)
    |> Enum.each(fn line -> IO.puts(line) end)

    IO.puts(" ")
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
        Rules.apply(grid, cell, {x, y})
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
