use Mix.Config

config :sound_place,
       SoundPlaceWeb.Endpoint,
       http: [port: 4000],
       debug_errors: true,
       code_reloader: true,
       check_origin: false,
       watchers: [node: ["node_modules/brunch/bin/brunch", "watch", "--stdin",
                    cd: Path.expand("../assets", __DIR__)]]

config :sound_place,
       SoundPlaceWeb.Endpoint,
       live_reload: [
         patterns: [
           ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
           ~r{priv/gettext/.*(po)$},
           ~r{lib/sound_place_web/views/.*(ex)$},
           ~r{lib/sound_place_web/templates/.*(eex)$}
         ]
       ]

config :logger, :console, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20

config :sound_place,
       SoundPlace.Repo,
       adapter: Ecto.Adapters.Postgres,
       username: System.get_env("SOUND_PLACE_DB_USERNAME"),
       password: System.get_env("SOUND_PLACE_DB_PASSWORD"),
       database: "sound_place_dev",
       hostname: System.get_env("SOUND_PLACE_DB_HOST"),
       pool_size: 10
