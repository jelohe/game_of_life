defmodule GameOfLifeTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  test "draws a string" do
    world = """
    ...................
    ........o.....oo...
    ....o..o.o.........
    .......o.oo..o.....
    ....o....o.........
    ...................
    """

    assert capture_io(fn ->
             GameOfLife.draw(world)
           end) =~ world
  end

  test "creates a grid of the world" do
    world = """
    ...
    ...
    ...
    """
    grid = [
      [".",".","."],
      [".",".","."],
      [".",".","."],
    ]

    assert GameOfLife.to_grid(world) == grid
  end

  test "a cell dies if it has fewer than two neighbours" do
    world = """
    ...
    .o.
    ...
    """

    expected_world = """
    ...
    ...
    ...
    """

    assert capture_io(fn ->
      world
      |> GameOfLife.next()
      |> GameOfLife.draw()
    end) =~ expected_world
  end

  test "a cell stays alive if it has more than one neighbour" do
    world = """
    .o.
    oo.
    ...
    """

    assert capture_io(fn ->
      world
      |> GameOfLife.next()
      |> GameOfLife.draw()
     end) =~ world
  end
end

