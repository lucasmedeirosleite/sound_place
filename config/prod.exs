use Mix.Config

config :sound_place, 
       SoundPlaceWeb.Endpoint,
       load_from_system_env: true,
       http: [port: System.get_env("PORT")],
       url: [host: System.get_env("HOST"), port: System.get_env("PORT")],
       cache_static_manifest: "priv/static/cache_manifest.json",
       secret_key_base: System.get_env("SECRET_KEY_BASE")

config :sound_place,
       SoundPlace.Repo,
       adapter: Ecto.Adapters.Postgres,
       url: System.get_env("SOUND_PLACE_DB_URL"),
       pool_size: String.to_integer(System.get_env("POOL_SIZE") || "20"),
       ssl: false

config :logger, level: :info
