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

  pipeline :admin_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.EnsureAuthenticated, handler: SoundPlaceWeb.SessionController
    plug Guardian.Plug.LoadResource
    plug SoundPlaceWeb.CurrentUser
  end

  scope "/", SoundPlaceWeb do
    pipe_through :browser

    get "/", HomeController, :index
    resources "/sessions", SessionController, only: [:new, :create, :delete], singleton: true
  end

  scope "/admin", SoundPlaceWeb.Admin, as: :admin do
    pipe_through [:browser, :admin_session]

    resources "/dashboard", DashboardController, only: [:index]
    resources "/users", UserController, except: [:show, :edit, :update]
    resources "/genres", GenreController, except: [:show]
    resources "/labels", LabelController, except: [:show]
    resources "/album_types", AlbumTypeController, except: [:show]
    resources "/artists", ArtistController, except: [:show] do
      resources "/albums", AlbumController, except: [:show]
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", SoundPlaceWeb do
  #   pipe_through :api
  # end
end
