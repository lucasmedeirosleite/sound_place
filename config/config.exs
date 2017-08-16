use Mix.Config

config :sound_place,
       ecto_repos: [SoundPlace.Repo]

config :sound_place,
       SoundPlaceWeb.Endpoint,
       url: [host: "localhost"],
       secret_key_base: "b7csCBTgJYFyBoCSfQjqpR0ak/0xcvQs8nNb3fWqu2XFoz4VRcWY2a+fJbvMzC2p",
       render_errors: [view: SoundPlaceWeb.ErrorView, accepts: ~w(html json)],
       pubsub: [name: SoundPlace.PubSub, adapter: Phoenix.PubSub.PG2]

config :logger, :console, format: "$time $metadata[$level] $message\n", metadata: [:request_id]

import_config "#{Mix.env}.exs"
