defmodule SoundPlaceWeb.Admin.DashboardController do
  use SoundPlaceWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
