defmodule SoundPlace.Transformer.ArtistsWorker do
  use GenServer

  @timeout Application.get_env(:sound_place, :workers_timeout)

  # Client Interface

  def start_link(user_id, artists_map) do
    state = %{user_id: user_id, artists_map: artists_map}
    GenServer.start_link(__MODULE__, state, name: via_tuple(user_id))
  end

  def transform_all(user_id) do
    GenServer.call(via_tuple(user_id), :transform_all, @timeout)
  end

  # Server Callbacks

  def init(state) do
    {:ok, state}
  end

  def handle_call(:transform_all, _from, %{artists_map: artists, user_id: _user_id} = state) do
    artists = SoundPlace.Transformer.transform_artists(artists)
    {:reply, {:ok, artists}, state}
  end

  # Private functions

  defp via_tuple(user_id) do
    {:via, :gproc, {:n, :l, {:artists_transformer_worker, set_worker_name(user_id)}}}
  end

  defp set_worker_name(user_id) do
    "artists-transformer-worker-#{user_id}"
  end
end