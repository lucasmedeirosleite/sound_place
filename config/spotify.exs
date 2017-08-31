use Mix.Config

config :spotify_ex, user_id: System.get_env("SPOTIFY_USER_ID"),
                    scopes: ["playlist-read-private",
                             "playlist-read-collaborative",
                             "playlist-modify-private",
                             "playlist-modify-public",
                             "user-follow-read",
                             "user-library-read",
                             "user-library-modify",
                             "user-read-private",
                             "user-read-email",
                             "user-read-currently-playing"
                            ],
                    callback_url: System.get_env("SPOTIFY_CALLBACK_URL")
