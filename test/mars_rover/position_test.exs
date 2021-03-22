defmodule MarsRover.PositionTest do
  use ExUnit.Case

  alias MarsRover.Position

  test "create new Position" do
    {:ok, %Position{row: row, col: col}} = Position.create(1, 2)

    assert row === 1
    assert col === 2
  end

  test "attempt to create new Position with out of range row" do
    {:error, msg} = Position.create(11, 0)

    assert msg === :invalid_position
  end

  test "attempt to create new Position with out of range col" do
    {:error, msg} = Position.create(0, 11)

    assert msg === :invalid_position
  end

  test "update position" do
    {:ok, position} = Position.create(1, 2)

    {:ok, new_position} =
      position
      |> Position.update(1, 1)

    assert new_position.row === 2
    assert new_position.col === 3
  end

  test "update position with row is out of bound" do
    {:ok, position} = Position.create(5, 1)

    {:ok, new_position} =
      position
      |> Position.update(2, 0)

    assert new_position.row === 6
    assert new_position.col === 1
  end

  test "update position with col is out of bound" do
    {:ok, position} = Position.create(1, 5)

    {:ok, new_position} =
      position
      |> Position.update(0, 2)

    assert new_position.row === 1
    assert new_position.col === 6
  end
end
