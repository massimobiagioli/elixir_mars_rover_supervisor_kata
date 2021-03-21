defmodule MarsRover.MarsRoverTest do
  use ExUnit.Case

  alias MarsRover.Position
  alias MarsRover.MarsRover

  test "create new Mars Rover" do
    {:ok, position} = Position.create(1, 2)
    {:ok, mars_rover} = MarsRover.create("frank", position, :north)

    assert mars_rover.name === "frank"
    assert mars_rover.position.row === 1
    assert mars_rover.position.col === 2
    assert mars_rover.orientation === :north
  end

  test "attempt to create new Mars Rover with invalid orientation" do
    {:ok, position} = Position.create(1, 2)
    {:error, msg} = MarsRover.create("frank", position, :wrong_orientation)

    assert msg === :invalid_orientation
  end

  test "turn right Mars Rover" do
    {:ok, position} = Position.create(1, 2)
    {:ok, mars_rover} = MarsRover.create("frank", position, :north)

    mars_rover =
      mars_rover
      |> MarsRover.turn_right()

    assert mars_rover.orientation === :east
  end

  test "turn left Mars Rover" do
    {:ok, position} = Position.create(1, 2)
    {:ok, mars_rover} = MarsRover.create("frank", position, :west)

    mars_rover =
      mars_rover
      |> MarsRover.turn_left()

    assert mars_rover.orientation === :south
  end

  test "move forward Mars Rover" do
    {:ok, position} = Position.create(1, 1)
    {:ok, mars_rover} = MarsRover.create("frank", position, :north)

    mars_rover =
      mars_rover
      |> MarsRover.move_forward()

    assert mars_rover.position.row === 1
    assert mars_rover.position.col === 2
  end

  test "move backward Mars Rover" do
    {:ok, position} = Position.create(2, 1)
    {:ok, mars_rover} = MarsRover.create("frank", position, :east)

    mars_rover =
      mars_rover
      |> MarsRover.move_backward()

    assert mars_rover.position.row === 1
    assert mars_rover.position.col === 1
  end
end
