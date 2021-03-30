defmodule MarsRover.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    options = [
      strategy: :one_for_one,
      name: MarsRoverApplicaton.Supervisor
    ]

    DynamicSupervisor.start_link(options)
  end

  def init_rover(args) do
    DynamicSupervisor.start_child(
      MarsRoverApplicaton.Supervisor,
      {MarsRover.MarsRoverWorker, args}
    )
  end

  def terminate_rover(pid) do
    DynamicSupervisor.terminate_child(MarsRoverApplicaton.Supervisor, pid)
  end
end
