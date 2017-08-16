defmodule SoundPlace.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      supervisor(SoundPlace.Repo, []),
      supervisor(SoundPlaceWeb.Endpoint, []),
      # Start your own worker by calling: SoundPlace.Worker.start_link(arg1, arg2, arg3)
      # worker(SoundPlace.Worker, [arg1, arg2, arg3]),
    ]

    opts = [strategy: :one_for_one, name: SoundPlace.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    SoundPlaceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
