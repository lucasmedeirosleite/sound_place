defmodule SoundPlace.Transformer.Services.PlaylistService do
  alias SoundPlace.Transformer.PlaylistsWorker
  alias SoundPlace.Supervisors.PlaylistsSupervisor

  @supervisor_id :playlists_transformer_sup

  def transform_all(from: user_id, with: playlists) do
    with {:ok, _pid} <- PlaylistsSupervisor.transformer_with(@supervisor_id, user_id: user_id, playlists: playlists),
         {:ok, playlists} <- PlaylistsWorker.transform_all(user_id) do
    
      {:ok, playlists}
    else 
      error ->
        {:error, error}
    end  
  end
end