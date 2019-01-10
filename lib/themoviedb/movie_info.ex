defmodule Themoviedb.MovieInfo do
  @type t :: %__MODULE__{
          name: String.t(),
          title: String.t(),
          language: String.t(),
          rating: float,
          release_date: Date.t(),
          related_movies: list(__MODULE__.t())
        }

  @enforce_keys [:name, :title, :language, :rating, :release_date]
  defstruct @enforce_keys ++ [related_movies: []]

  @spec from_tmdb(list(map)) :: __MODULE__.t()
  def from_tmdb(tmdb_movies) when is_list(tmdb_movies) do
    [tmdb_movie | tmdb_movies] = tmdb_movies

    movie_info = from_tmdb(tmdb_movie)

    related_movies = Enum.map(tmdb_movies, &from_tmdb/1)

    Map.put(movie_info, :related_movies, related_movies)
  end

  @spec from_tmdb(map) :: __MODULE__.t()
  def from_tmdb(tmdb_movie) do
    release_date = tmdb_movie |> Map.get("release_date") |> Date.from_iso8601!()

    %__MODULE__{
      name: Map.get(tmdb_movie, "original_title"),
      title: Map.get(tmdb_movie, "title"),
      language: Map.get(tmdb_movie, "original_language"),
      release_date: release_date,
      rating: Map.get(tmdb_movie, "vote_average")
    }
  end
end
