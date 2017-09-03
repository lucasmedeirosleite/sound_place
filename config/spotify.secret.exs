use Mix.Config

config :spotify_ex, client_id: System.get_env("SPOTIFY_CLIENT_ID"),
                    secret_key: System.get_env("SPOTIFY_SECRET_KEY")
