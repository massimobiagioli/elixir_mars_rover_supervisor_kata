defmodule MarsRover.Position do
  @moduledoc false

  alias __MODULE__

  @enforce_keys [:row, :col]
  defstruct [:row, :col]

  @min_position 0
  @max_position 6
  def create(row, col)
      when row <= @max_position and row >= 0 and col <= @max_position and col >= 0,
      do: {:ok, %Position{row: row, col: col}}

  def create(_row, _col), do: {:error, :invalid_position}

  def update(%Position{row: row, col: col}, row_offset, col_offset) do
    row =
      cond do
        row + row_offset > @max_position -> @max_position
        row + row_offset < @min_position -> @min_position
        true -> row + row_offset
      end

    col =
      cond do
        col + col_offset > @max_position -> @max_position
        col + col_offset < @min_position -> @min_position
        true -> col + col_offset
      end

    {:ok, %Position{row: row, col: col}}
  end
end
