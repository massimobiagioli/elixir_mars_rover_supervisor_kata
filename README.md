# ElixirMarsRoverSupervisorKata

## Supervisor usage

```elixir
args=%{"name"=>"mario", "row"=>2, "col"=>3, "orientation"=>:north}
MarsRoverSupervisor.init_mars_rover(args)
Supervisor.count_children(MarsRoverSupervisor)
MarsRoverSupervisor.terminate_mars_rover("mario")
```
