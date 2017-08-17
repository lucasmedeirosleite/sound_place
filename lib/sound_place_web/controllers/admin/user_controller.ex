defmodule SoundPlaceWeb.Admin.UserController do
  use SoundPlaceWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end
end
