defmodule MarsRover.MarsRoverSupervisor do
  use DynamicSupervisor

  alias MarsRover.MarsRoverWorker

  def start_link(arg),
    do: DynamicSupervisor.start_link(__MODULE__, arg, name: __MODULE__)

  def init(_arg),
    do: DynamicSupervisor.init(strategy: :one_for_one)

  def init_mars_rover(args),
    do:
      DynamicSupervisor.start_child(
        __MODULE__,
        {MarsRover.MarsRoverWorker, args}
      )

  def terminate_mars_rover(name),
    do: DynamicSupervisor.terminate_child(__MODULE__, pid_from_name(name))

  defp pid_from_name(name) do
    name
    |> MarsRoverWorker.via_tuple()
    |> GenServer.whereis()
  end
end
