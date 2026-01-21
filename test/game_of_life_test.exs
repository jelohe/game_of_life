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

    expected_world = """
    oo.
    oo.
    ...
    """

    assert capture_io(fn ->
             world
             |> GameOfLife.next()
             |> GameOfLife.draw()
           end) =~ expected_world
  end

  test "a cell dies from overcrowding if more three neighbours are alive" do
    world = """
    .o.
    ooo
    .o.
    """

    expected_world = """
    ooo
    o.o
    ooo
    """

    assert capture_io(fn ->
             world
             |> GameOfLife.next()
             |> GameOfLife.draw()
           end) =~ expected_world
  end

  test "any live cell with two or three live neighbours lives" do
    world = """
    .o.
    o.o
    .o.
    """

    assert capture_io(fn ->
             world
             |> GameOfLife.next()
             |> GameOfLife.draw()
           end) =~ world
  end

  test "any dead cell with exactly three live neighbours becomes a live cell" do
    world = """
    ...
    o.o
    .o.
    """

    expected_world = """
    ...
    .o.
    .o.
    """

    assert capture_io(fn ->
             world
             |> GameOfLife.next()
             |> GameOfLife.draw()
           end) =~ expected_world
  end
end
