defmodule SoundPlaceWeb.Router do
  use SoundPlaceWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SoundPlaceWeb do
    pipe_through :browser

    get "/", HomeController, :index
  end

  scope "/admin", SoundPlaceWeb.Admin, as: :admin do
    pipe_through :browser

    resources "/dashboard", DashboardController, only: [:index]
  end

  # Other scopes may use custom stacks.
  # scope "/api", SoundPlaceWeb do
  #   pipe_through :api
  # end
end
