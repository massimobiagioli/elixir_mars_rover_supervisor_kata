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
end
