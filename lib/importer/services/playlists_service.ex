defmodule SoundPlace.Importer.Services.PlaylistService do
  alias SoundPlace.Importer.PlaylistsWorker
  alias SoundPlace.Supervisors.PlaylistsSupervisor

  @supervisor_id :playlists_importer_sup

  def import_all(from: user_id, with: playlists) do
    with {:ok, _pid} <- PlaylistsSupervisor.importer_with(@supervisor_id, user_id: user_id, playlists: playlists),
         :ok <- PlaylistsWorker.import_all(user_id) do
    
      :ok
    else 
      error ->
        {:error, error}
    end  
  end
end