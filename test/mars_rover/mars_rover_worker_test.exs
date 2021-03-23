defmodule MarsRoverWorker.MarsRoverWorkerTest do
  use ExUnit.Case, async: true

  alias MarsRover.MarsRoverWorker

  test "whoami" do
    {:ok, pid} =
      start_supervised(
        {MarsRoverWorker,
         %{
           "name" => "zak",
           "row" => 1,
           "col" => 2,
           "orientation" => :north
         }}
      )

    assert MarsRoverWorker.whoami(pid) === "zak"
  end

  test "locate" do
    {:ok, pid} =
      start_supervised(
        {MarsRoverWorker,
         %{
           "name" => "zak",
           "row" => 1,
           "col" => 2,
           "orientation" => :north
         }}
      )

    %{position: position, orientation: orientation} = MarsRoverWorker.locate(pid)
    assert position.row === 1
    assert position.col === 2
    assert orientation === :north
  end

  test "turn_right" do
    {:ok, pid} =
      start_supervised(
        {MarsRoverWorker,
         %{
           "name" => "zak",
           "row" => 1,
           "col" => 1,
           "orientation" => :north
         }}
      )

    orientation = MarsRoverWorker.turn_right(pid)
    assert orientation === :east
  end

  test "turn_left" do
    {:ok, pid} =
      start_supervised(
        {MarsRoverWorker,
         %{
           "name" => "zak",
           "row" => 1,
           "col" => 1,
           "orientation" => :north
         }}
      )

    orientation = MarsRoverWorker.turn_left(pid)
    assert orientation === :west
  end

  test "move_forward" do
    {:ok, pid} =
      start_supervised(
        {MarsRoverWorker,
         %{
           "name" => "zak",
           "row" => 1,
           "col" => 2,
           "orientation" => :north
         }}
      )

    position = MarsRoverWorker.move_forward(pid)
    assert position.row === 2
    assert position.col === 2
  end

  test "move_backward" do
    {:ok, pid} =
      start_supervised(
        {MarsRoverWorker,
         %{
           "name" => "zak",
           "row" => 1,
           "col" => 3,
           "orientation" => :east
         }}
      )

    position = MarsRoverWorker.move_backward(pid)
    assert position.row === 1
    assert position.col === 2
  end
end
