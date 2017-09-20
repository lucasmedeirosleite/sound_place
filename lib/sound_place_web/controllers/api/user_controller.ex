defmodule SoundPlaceWeb.API.UserController do
  use SoundPlaceWeb, :controller
  alias SoundPlace.Provider
  alias SoundPlace.Importer

  action_fallback SoundPlaceWeb.API.Fallback.UserController

  def playlists(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    playlists = SoundPlace.Library.list_playlists(user.id)

    render(conn, "playlists.json", playlists: playlists)
  end

  def import(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    credentials = user.spotify_credential

    with {:ok, data} <- Provider.playlists(credentials, credentials.spotify_id),
         {:ok, playlists} <- Importer.import_playlists(user, data) do
      
      render(conn, "playlists.json", playlists: playlists)  
    end 
  end
end
