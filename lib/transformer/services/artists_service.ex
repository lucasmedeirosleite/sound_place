defmodule SoundPlace.Transformer.Services.ArtistsService do
  alias SoundPlace.Transformer.ArtistsWorker
  alias SoundPlace.Supervisors.ArtistsSupervisor

  @supervisor_id :artists_transformer_sup

  def transform_all(from: user_id, with: artists) do
    with {:ok, _pid} <- ArtistsSupervisor.transformer_with(@supervisor_id, user_id: user_id, artists: artists),
         {:ok, artists} <- ArtistsWorker.transform_all(user_id) do
    
      {:ok, artists}
    else 
      error ->
        {:error, error}
    end  
  end
end