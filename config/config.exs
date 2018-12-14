use Mix.Config

config :themoviedb_alexa,
  tmdb_client: ThemoviedbAlexa.Themoviedb.Client

# The file below will contain the tmdb lib api key
import_config "config.secret.exs"

if Mix.env() == :lambda do
  import_config "#{Mix.env()}.exs"
end

if Mix.env() == :test do
  import_config "#{Mix.env()}.exs"
end
