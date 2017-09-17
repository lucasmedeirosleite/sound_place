defmodule SoundPlaceWeb.API.UserController do
  use SoundPlaceWeb, :controller
  alias SoundPlace.Library

  def playlists(conn, _params) do
    user = Guardian.Plug.current_resource(conn)

    render(conn, "playlists.json", playlists: Library.playlists(user.id))
  end
end
