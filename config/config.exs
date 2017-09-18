use Mix.Config

config :sound_place,
       web_app_url: System.get_env("SOUND_PLACE_WEB_APP")

config :sound_place,
       ecto_repos: [SoundPlace.Repo]

config :sound_place,
       SoundPlaceWeb.Endpoint,
       url: [host: "localhost"],
       secret_key_base: "b7csCBTgJYFyBoCSfQjqpR0ak/0xcvQs8nNb3fWqu2XFoz4VRcWY2a+fJbvMzC2p",
       render_errors: [view: SoundPlaceWeb.ErrorView, accepts: ~w(html json)],
       pubsub: [name: SoundPlace.PubSub, adapter: Phoenix.PubSub.PG2]

config :guardian,
       Guardian,
       allowed_algos: ["HS512"],
       verify_module: Guardian.JWT,
       issuer: "SoundPlace.#{Mix.env}",
       ttl: { 30, :days },
       allowed_drift: 2000,
       verify_issuer: true,
       secret_key: System.get_env("GUARDIAN_SECRET_KEY"),
       serializer: SoundPlaceWeb.GuardianSerializer

config :logger, :console, format: "$time $metadata[$level] $message\n", metadata: [:request_id]

import_config "spotify.exs"
import_config "spotify.secret.exs"

import_config "#{Mix.env}.exs"
