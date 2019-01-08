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

        {:ok, release_date} = movie |> Map.get("release_date") |> Date.from_iso8601!()

        {
          :ok,
          %MovieInfo{
            name: movie_name,
            release_date: release_date,
            rating: Map.get(movie, "vote_average")
          }
        }

      movies ->
        Logger.info("Multiple movies | #{movie_name}")
        movie = List.first(movies)
        {:ok, movie_name, Map.get(movie, "vote_average")}
    end
  end
end
