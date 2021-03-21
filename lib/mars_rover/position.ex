defmodule MarsRover.Position do
  @moduledoc false

  alias __MODULE__

  @enforce_keys [:row, :col]
  defstruct [:row, :col]

  @range 1..10

  def create(row, col) when row in @range and col in @range,
    do: {:ok, %Position{row: row, col: col}}

  def create(_row, _col), do: {:error, :invalid_position}
end
