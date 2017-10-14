defmodule SoundPlace.Supervisors.PlaylistsSupervisor do
  use Supervisor

  # Client API

  def start_link(name, worker) do
    state = %{worker: worker, name: name}
    Supervisor.start_link(__MODULE__, state, name: via_tuple(name))
  end

  def provider_with(supervisor_name, user_id: user_id) do
    worker_with(supervisor_name, [user_id])
  end

  def transformer_with(supervisor_name, user_id: user_id, playlists: playlists) do
    worker_with(supervisor_name, [user_id, playlists])
  end

  def importer_with(supervisor_name, user_id: user_id, playlists: playlists) do
    worker_with(supervisor_name, [user_id, playlists])
  end

  # Supervisor callbacks

  def init(%{worker: worker_module} = _state) do
    children = [
      worker(worker_module, [], restart: :transient)
    ]

    Supervisor.init(children, strategy: :simple_one_for_one)
  end

  # Private methods

  def worker_with(supervisor_name, args) do
    case Supervisor.start_child(via_tuple(supervisor_name), args) do
      {:ok, pid} -> {:ok, pid}
      {:error, {:already_started, pid}} -> {:ok, pid}
    end
  end

  defp via_tuple(name) do
    {:via, :gproc, {:n, :l, {:playlists_supervisor, name}}}
  end
end
