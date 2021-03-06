defmodule MarsRover.MarsRover do
  @moduledoc false

  alias MarsRover.Position
  alias MarsRover.MarsRover

  @enforce_keys [:name, :position, :orientation]
  defstruct [:name, :position, :orientation]

  @types [:north, :south, :east, :west]

  @orientation_map %{
    "north" => %{"right" => :east, "left" => :west},
    "south" => %{"right" => :west, "left" => :east},
    "east" => %{"right" => :south, "left" => :north},
    "west" => %{"right" => :north, "left" => :south}
  }

  @movement_map %{
    "north" => %{
      "row" => %{"forward" => 1, "backward" => -1},
      "col" => %{"forward" => 0, "backward" => 0}
    },
    "south" => %{
      "row" => %{"forward" => -1, "backward" => 1},
      "col" => %{"forward" => 0, "backward" => 0}
    },
    "east" => %{
      "row" => %{"forward" => 0, "backward" => 0},
      "col" => %{"forward" => 1, "backward" => -1}
    },
    "west" => %{
      "row" => %{"forward" => 0, "backward" => 0},
      "col" => %{"forward" => -1, "backward" => 1}
    }
  }

  def create(_name, _position, orientation) when orientation not in @types,
    do: {:error, :invalid_orientation}

  def create(name, position, orientation),
    do: {:ok, %MarsRover{name: name, position: position, orientation: orientation}}

  def turn_right(%MarsRover{name: name, position: position, orientation: orientation}) do
    new_orientation = change_orientation(orientation, :right)

    {:ok, mars_rover} = create(name, position, new_orientation)
    mars_rover
  end

  def turn_left(%MarsRover{name: name, position: position, orientation: orientation}) do
    new_orientation = change_orientation(orientation, :left)

    {:ok, mars_rover} = create(name, position, new_orientation)
    mars_rover
  end

  def move_forward(%MarsRover{orientation: orientation} = mars_rover),
    do:
      update_position(
        mars_rover,
        calculate_offset(orientation, :row, :forward),
        calculate_offset(orientation, :col, :forward)
      )

  def move_backward(%MarsRover{orientation: orientation} = mars_rover),
    do:
      update_position(
        mars_rover,
        calculate_offset(orientation, :row, :backward),
        calculate_offset(orientation, :col, :backward)
      )

  defp change_orientation(orientation, new_direction),
    do:
      Map.get(
        Map.get(
          @orientation_map,
          Atom.to_string(orientation)
        ),
        Atom.to_string(new_direction)
      )

  defp calculate_offset(orientation, type, direction),
    do:
      Map.get(
        Map.get(
          Map.get(
            @movement_map,
            Atom.to_string(orientation)
          ),
          Atom.to_string(type)
        ),
        Atom.to_string(direction)
      )

  defp update_position(
         %MarsRover{name: name, position: position, orientation: orientation},
         row_offset,
         col_offset
       ) do
    {:ok, new_position} =
      position
      |> Position.update(row_offset, col_offset)

    {:ok, mars_rover} = create(name, new_position, orientation)
    mars_rover
  end
end
