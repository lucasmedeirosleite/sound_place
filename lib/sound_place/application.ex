defmodule SoundPlace.Application do
  use Application
  
  alias SoundPlace.Importer
  alias SoundPlace.Provider
  alias SoundPlace.Transformer
  alias SoundPlace.Supervisors.PlaylistsSupervisor
  alias SoundPlace.Supervisors.ArtistsSupervisor

  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      supervisor(SoundPlace.Repo, []),
      supervisor(SoundPlaceWeb.Endpoint, []),
      supervisor(PlaylistsSupervisor, 
                 [:playlists_provider_sup, Provider.PlaylistsWorker], 
                 id: :playlists_provider_sup
                ),
      supervisor(PlaylistsSupervisor, 
                 [:playlists_transformer_sup, Transformer.PlaylistsWorker],
                 id: :playlists_transformer_sup
                ),
      supervisor(PlaylistsSupervisor, 
                 [:playlists_importer_sup, Importer.PlaylistsWorker],
                 id: :playlists_importer_sup
                ),
      supervisor(ArtistsSupervisor, 
                 [:artists_provider_sup, Provider.ArtistsWorker],
                 id: :artists_provider_sup
                ),
      supervisor(ArtistsSupervisor, 
                 [:artists_transformer_sup, Transformer.ArtistsWorker],
                 id: :artists_transformer_sup
                )                    
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
