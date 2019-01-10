defmodule Themoviedb.MovieInfoTest do
  use ExUnit.Case
  use ExUnitProperties

  alias Themoviedb.MovieInfo

  alias ThemoviedbAlexa.Test.Support.DateGenerator

  def gen_tmdb_movies do
    gen all vote_count <- StreamData.positive_integer(),
            id <- StreamData.integer(),
            video <- StreamData.boolean(),
            vote_average <- StreamData.float(),
            title <- StreamData.string(:alphanumeric, min_length: 1),
            popularity <- StreamData.float(),
            poster_path <- StreamData.string(:alphanumeric),
            original_language <- StreamData.string(:alphanumeric, min_length: 1),
            original_title <- StreamData.string(:alphanumeric, min_length: 1),
            genre_ids <- StreamData.list_of(StreamData.positive_integer()),
            backdrop_path <- StreamData.string(:alphanumeric),
            adult <- StreamData.boolean(),
            overview <- StreamData.string(:alphanumeric, min_length: 1),
            {date_struct, date_iso8601} <- DateGenerator.gen_date_string() do
      target_expect = %MovieInfo{
        name: original_title,
        title: title,
        language: original_language,
        release_date: date_struct,
        rating: vote_average
      }

      source_map = %{
        "vote_count" => vote_count,
        "id" => id,
        "video" => video,
        "vote_average" => vote_average,
        "title" => title,
        "popularity" => popularity,
        "poster_path" => poster_path,
        "original_language" => original_language,
        "original_title" => original_title,
        "genre_ids" => genre_ids,
        "backdrop_path" => backdrop_path,
        "adult" => adult,
        "overview" => overview,
        "release_date" => date_iso8601
      }

      {target_expect, source_map}
    end
  end

  describe "Given a tmdb response" do
    property "the tmdb movie information is mapped to MovieInfo struc" do
      check all movies <- StreamData.list_of(gen_tmdb_movies(), min_length: 1) do
        tmdb_movies = Enum.map(movies, fn {_, tmdb_movie} -> tmdb_movie end)

        [movie_info | related_movies] =
          Enum.map(movies, fn {expected_movie_info, _} -> expected_movie_info end)

        expect_movie_info = Map.put(movie_info, :related_movies, related_movies)

        movie_info = MovieInfo.from_tmdb(tmdb_movies)

        assert expect_movie_info == movie_info
      end
    end
  end
end
