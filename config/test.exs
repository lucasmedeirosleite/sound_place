use Mix.Config

config :sound_place,
       SoundPlaceWeb.Endpoint,
       http: [port: 4001],
       server: false

config :logger, level: :warn

config :sound_place,
       SoundPlace.Repo,
       adapter: Ecto.Adapters.Postgres,
       username: "postgres",
       password: "postgres",
       database: "sound_place_test",
       hostname: "db",
       pool: Ecto.Adapters.SQL.Sandbox
