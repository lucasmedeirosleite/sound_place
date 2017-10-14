defmodule SoundPlace.Provider.PlaylistsWorker do
  use GenServer

  alias SoundPlace.Accounts
  alias SoundPlace.Provider

  @timeout Application.get_env(:sound_place, :workers_timeout)

  # Client Interface

  def start_link(user_id) do
    state = %{user_id: user_id}
    GenServer.start_link(__MODULE__, state, name: via_tuple(user_id))
  end

  def get_playlists(user_id) do
    GenServer.call(via_tuple(user_id), :get_playlists, @timeout)
  end

  # Server Callbacks

  def init(state) do
    {:ok, state}
  end

  def handle_call(:get_playlists, _from, %{user_id: user_id} = state) do
    credentials = Accounts.get_credentials(user_id: user_id)
    
    case Provider.all_playlists(credentials) do
      {:ok, result} ->
        new_state = state |> Map.put(:playlists, result)
        {:reply, {:ok, result}, new_state}
      _ ->
        new_state = state |> Map.put(:playlists, [])
        {:reply, {:ok, []}, new_state}
    end
  end

  # Private functions

  defp via_tuple(user_id) do
    {:via, :gproc, {:n, :l, {:playlists_provider_worker, set_worker_name(user_id)}}}
  end

  defp set_worker_name(user_id) do
    "playlist-provider-worker-#{user_id}"
  end
end