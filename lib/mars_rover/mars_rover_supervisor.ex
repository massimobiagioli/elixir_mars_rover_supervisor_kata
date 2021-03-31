defmodule MarsRover.MarsRoverSupervisor do
  use DynamicSupervisor

  def start_link(arg),
    do: DynamicSupervisor.start_link(__MODULE__, arg, name: __MODULE__)

  def init(_arg),
    do: DynamicSupervisor.init(strategy: :one_for_one)

  def init_mars_rover(args),
    do:
      DynamicSupervisor.start_child(
        MarsRoverApplicaton.Supervisor,
        {MarsRover.MarsRoverWorker, args}
      )

  def terminate_mars_rover(pid),
    do: DynamicSupervisor.terminate_child(MarsRoverApplicaton.Supervisor, pid)
end
