defmodule Rules do
  @alive "o"
  @dead "."

  def apply_all(grid, cell, pos) do
    alive_neighbours = grid
                       |> get_neighbours(pos)
                       |> count_alive()

    next_cell(cell, alive_neighbours)
  end

  defp next_cell(@alive, neighbours) when neighbours < 2, do: @dead
  defp next_cell(@alive, neighbours) when neighbours in 2..3, do: @alive
  defp next_cell(@alive, neighbours) when neighbours > 3, do: @dead
  defp next_cell(@dead, 3), do: @alive
  defp next_cell(@dead, _), do: @dead

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
        nx >= 0 and nx < width,
        ny >= 0 and ny < height do
      grid
      |> Enum.at(ny)
      |> Enum.at(nx)
    end
  end
end
