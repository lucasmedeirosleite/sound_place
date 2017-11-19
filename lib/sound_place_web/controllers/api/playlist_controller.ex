defmodule SoundPlaceWeb.API.PlaylistController do
  use SoundPlaceWeb, :controller
  alias SoundPlace.Accounts
  alias SoundPlace.Provider
  alias SoundPlace.Transformer
  alias SoundPlace.Importer

  def tracks(conn, %{"playlist_id" => playlist_id}) do
    user_id = Guardian.Plug.current_resource(conn).id
    credentials = Accounts.get_credentials(user_id: user_id)
    playlist = SoundPlace.Library.get_playlist(spotify_id: playlist_id)

    case playlist.tracks do
      [] ->
        with {:ok, tracks_map} <- Provider.playlist_tracks(credentials, playlist_id),
             {playlist, converted_tracks} <- Transformer.transform_tracks(playlist, tracks_map),
             {:ok, tracks } <- Importer.import_tracks(playlist, converted_tracks) do
          
          render(conn, "tracks.json", tracks: tracks)
        else _ ->
          render(conn, "tracks.json", tracks: [])
        end
      tracks ->
        render(conn, "tracks.json", tracks: tracks)
    end
  end
end
