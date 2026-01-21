defmodule RulesTest do
  use ExUnit.Case

  test "gets the neighbours of a cell" do
    grid = [
      [".", ".", "o"],
      [".", "o", "."],
      [".", ".", "."]
    ]

    assert Rules.get_neighbours(grid, {1, 1}) ==
             [".", ".", ".", ".", ".", "o", ".", "."]

    assert Rules.get_neighbours(grid, {0, 0}) ==
             [".", ".", "o"]

    assert Rules.get_neighbours(grid, {2, 2}) ==
             ["o", ".", "."]
  end

  test "counts neighbours alive" do
    grid = [
      [".", ".", "o"],
      [".", "o", "."],
      ["o", ".", "o"],
    ]

    neighbours = Rules.get_neighbours(grid, {1, 1})
    assert Rules.count_alive(neighbours) == 3
  end
end
