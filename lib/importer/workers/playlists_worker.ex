defmodule SoundPlace.Importer.PlaylistsWorker do
  use GenServer

  # Client Interface

  def start_link(user_id, playlists_map) do
    state = %{user_id: user_id, playlists_map: playlists_map}
    GenServer.start_link(__MODULE__, state, name: via_tuple(user_id))
  end

  def import_all(user_id) do
    GenServer.cast(via_tuple(user_id), :import_all)
  end

  # Server Callbacks

  def init(state) do
    {:ok, state}
  end

  def handle_cast(:import_all, %{playlists_map: playlists} = state) do
    playlists = SoundPlace.Library.save_playlists(playlists)
    new_state = Map.put(state, :playlists, playlists)
    {:noreply, new_state}
  end

  # Private functions

  defp via_tuple(user_id) do
    {:via, :gproc, {:n, :l, {:playlists_importer_worker, set_worker_name(user_id)}}}
  end

  defp set_worker_name(user_id) do
    "playlist-importer-worker-#{user_id}"
  end
end