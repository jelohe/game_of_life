defmodule GameOfLife do
  def draw(world) do
    world
    |> Normalize.parse()
    |> Enum.map(fn line -> Enum.join(line, "") end)
    |> Enum.each(fn line -> IO.puts(line) end)

    IO.puts(" ")
  end

  def next(world) do
    grid = Normalize.parse(world)
    grid
    |> Enum.with_index()
    |> Enum.map(fn {row, y} ->
      row
      |> Enum.with_index()
      |> Enum.map(fn {cell, x} ->
        Rules.apply_all(grid, cell, {x, y})
      end)
    end)
  end
end
