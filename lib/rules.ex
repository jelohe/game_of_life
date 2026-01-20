defmodule Rules do
  @alive "o"
  @dead "."

  def survive_rule(grid, cell, {x, y}) when cell == @alive do
    survive = grid
              |> get_neighbours({x, y})
              |> count_alive() >= 2
    if survive, do: @alive, else: @dead
  end

  def survive_rule(_, cell, _) when cell == @dead do
    @dead
  end

  def count_alive(neighbours) do
    neighbours
    |> Enum.count(fn x -> x == @alive end)
  end

  def get_neighbours(grid, {x, y}) do
    height = length(grid)
    width = length(hd(grid))

    for dx <- -1..1,
      dy <- -1..1,
      not (dx == 0 and dy == 0),
      nx = x + dx,
      ny = y + dy,
      nx >=0 and nx < width,
      ny >= 0 and ny < height do
        grid
        |> Enum.at(ny)
        |> Enum.at(nx)
    end
  end
end
