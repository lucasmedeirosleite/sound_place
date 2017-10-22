defmodule SoundPlaceWeb.API.UserController do
  use SoundPlaceWeb, :controller
  alias SoundPlace.Provider
  alias SoundPlace.Transformer
  alias SoundPlace.Importer

  action_fallback SoundPlaceWeb.API.Fallback.UserController

  def me(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, "me.json", user: user)
  end

  def playlists(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    playlists = SoundPlace.Library.list_playlists(user_id: user.id)

    render(conn, "playlists.json", playlists: playlists)
  end

  def artists(conn, _params) do
    user_id = Guardian.Plug.current_resource(conn).id

    case SoundPlace.Library.list_artists(user_id: user_id) do
      [] ->
        with {:ok, artists} <- Provider.Services.ArtistsService.get_all(from: user_id),
             {:ok, artists} <- Transformer.Services.ArtistsService.transform_all(from: user_id, with: artists) do
          
          render(conn, "artists.json", artists: artists)
        end
      artists ->
        render(conn, "artists.json", artists: artists)
    end
  end

  def import(conn, _params) do
    user_id = Guardian.Plug.current_resource(conn).id

    with {:ok, playlists} <- Provider.Services.PlaylistService.get_all(from: user_id),
         {:ok, playlists} <- Transformer.Services.PlaylistService.transform_all(from: user_id, with: playlists) do
      
      Importer.Services.PlaylistService.import_all(from: user_id, with: playlists)
      render(conn, "playlists.json", playlists: playlists)
    end
  end
end
