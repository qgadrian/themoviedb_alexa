use Mix.Config

config :themoviedb_alexa,
  tmdb_client: ThemoviedbAlexa.Themoviedb.ClientMock

config :logger,
  level: :warn
