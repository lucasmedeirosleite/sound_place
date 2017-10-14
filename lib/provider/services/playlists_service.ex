defmodule SoundPlace.Provider.Services.PlaylistService do
  alias SoundPlace.Provider.PlaylistsWorker
  alias SoundPlace.Supervisors.PlaylistsSupervisor

  @supervisor_id :playlists_provider_sup

  def get_all(from: user_id) do
    with {:ok, _worker_pid} <- PlaylistsSupervisor.provider_with(@supervisor_id, user_id: user_id),
         {:ok, playlists} <- PlaylistsWorker.get_playlists(user_id) do
    
      {:ok, playlists}
    else 
      error ->
        {:error, error}
    end  
  end
end