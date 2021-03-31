defmodule MarsRover.MarsRoverWorker do
  @moduledoc false

  alias MarsRover.Position
  alias MarsRover.MarsRover

  use GenServer

  def start_link(args) do
    {:ok, position} = Position.create(args["row"], args["col"])
    {:ok, mars_rover} = MarsRover.create(args["name"], position, args["orientation"])
    GenServer.start_link(__MODULE__, mars_rover, name: process_name(args))
  end

  def init(args), do: {:ok, args}

  @spec whoami(atom | pid | {atom, any} | {:via, atom, any}) :: any
  def whoami(pid), do: GenServer.call(pid, :whoami)

  def locate(pid), do: GenServer.call(pid, :locate)

  def move_forward(pid), do: GenServer.call(pid, :move_forward)

  def turn_right(pid), do: GenServer.call(pid, :turn_right)

  def turn_left(pid), do: GenServer.call(pid, :turn_left)

  def move_backward(pid), do: GenServer.call(pid, :move_backward)

  def handle_call(:whoami, _from, %MarsRover{name: name} = state), do: {:reply, name, state}

  def handle_call(
        :locate,
        _from,
        %MarsRover{position: position, orientation: orientation} = state
      ),
      do: {:reply, %{position: position, orientation: orientation}, state}

  def handle_call(:turn_right, _from, %MarsRover{} = state) do
    state =
      state
      |> MarsRover.turn_right()

    {:reply, state.orientation, state}
  end

  def handle_call(:turn_left, _from, %MarsRover{} = state) do
    state =
      state
      |> MarsRover.turn_left()

    {:reply, state.orientation, state}
  end

  def handle_call(:move_forward, _from, %MarsRover{} = state) do
    state =
      state
      |> MarsRover.move_forward()

    {:reply, state.position, state}
  end

  def handle_call(:move_backward, _from, %MarsRover{} = state) do
    state =
      state
      |> MarsRover.move_backward()

    {:reply, state.position, state}
  end

  defp process_name(args), do: String.to_atom(args["name"])
end
