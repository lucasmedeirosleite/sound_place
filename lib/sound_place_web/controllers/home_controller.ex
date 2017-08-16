defmodule SoundPlaceWeb.HomeController do
  use SoundPlaceWeb, :controller

  def index(conn, _params) do
    redirect(conn, to: admin_dashboard_path(conn, :index))
  end
end
