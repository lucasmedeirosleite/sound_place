defmodule SoundPlaceWeb.Router do
  use SoundPlaceWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :admin_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.EnsureAuthenticated, handler: SoundPlaceWeb.SessionController
    plug Guardian.Plug.LoadResource
    plug SoundPlaceWeb.CurrentUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :api_session do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  scope "/", SoundPlaceWeb do
    pipe_through :browser

    get "/", HomeController, :index

    get "/auth/spotify", AuthController, :spotify
    get "/auth/spotify/callback", AuthController, :callback

    resources "/admin/sessions", SessionController, only: [:new, :create, :delete], singleton: true
  end

  scope "/admin", SoundPlaceWeb.Admin, as: :admin do
    pipe_through [:browser, :admin_session]

    resources "/dashboard", DashboardController, only: [:index]
    resources "/users", UserController, except: [:show, :edit, :update]
    resources "/genres", GenreController, except: [:show]
    resources "/labels", LabelController, except: [:show]
    resources "/album_types", AlbumTypeController, except: [:show]
    resources "/artists", ArtistController, except: [:show] do
      resources "/albums", AlbumController, except: [:show] do
        resources "/tracks", TrackController, except: [:show] do
        end
      end
    end
  end

  scope "/api", SoundPlaceWeb.API, as: :api do
    pipe_through [:api, :api_session]

    get "/me/playlists", UserController, :playlists
    post "/me/import", UserController, :import
  end
end
