defmodule ThemoviedbAlexa.Themoviedb.Client do
  @moduledoc """
  Module to provide an internal API to get all the information supported by the Alexa Skill
  """
  require Logger

  alias Themoviedb.MovieInfo
  alias ThemoviedbAlexa.Session

  @behaviour ThemoviedbAlexa.Themoviedb.Client.Behaviour

  @impl true
  def rating(movie_name) do
    language = Session.language(RequestSession)

    %{"results" => movies} = Tmdb.Search.movies(movie_name, %{language: language})

    case movies do
      [] ->
        {:error, :movie_not_found}

      [movie | []] ->
        Logger.debug(inspect(movie))

        {:ok, MovieInfo.from_tmdb(movie)}

      movies ->
        Logger.info("Multiple movies | #{movie_name}")

        {:ok, MovieInfo.from_tmdb(movies)}
    end
  end
end
