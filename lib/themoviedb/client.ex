defmodule ThemoviedbAlexa.Themoviedb.Client do
  @moduledoc """
  Module to provide an internal API to get all the information supported by the Alexa Skill
  """
  require Logger

  @behaviour ThemoviedbAlexa.Themoviedb.Client.Behaviour

  @impl true
  def rating(movie_name) do
    %{"results" => movies} = Tmdb.Search.movies(movie_name)

    case movies do
      [] ->
        {:error, :movie_not_found}

      [movie | []] ->
        Logger.debug(inspect(movie))
        {:ok, movie_name, Map.get(movie, "vote_average")}

      movies ->
        Logger.info("Multiple movies | #{movie_name}")
        movie = List.first(movies)
        {:ok, movie_name, Map.get(movie, "vote_average")}
    end
  end
end
