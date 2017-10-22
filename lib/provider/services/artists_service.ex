defmodule SoundPlace.Provider.Services.ArtistsService do
  alias SoundPlace.Provider.ArtistsWorker
  alias SoundPlace.Supervisors.ArtistsSupervisor

  @supervisor_id :artists_provider_sup

  def get_all(from: user_id) do
    with {:ok, _worker_pid} <- ArtistsSupervisor.provider_with(@supervisor_id, user_id: user_id),
         {:ok, artists} <- ArtistsWorker.get_artists(user_id) do
    
      {:ok, artists}
    else 
      error ->
        {:error, error}
    end  
  end
end