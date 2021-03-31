defmodule MarsRover.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Registry, keys: :unique, name: MarsRoverRegistry},
      MarsRover.MarsRoverSupervisor
    ]

    opts = [strategy: :one_for_one, name: MarsRoverApplication.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
