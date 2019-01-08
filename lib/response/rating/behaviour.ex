defmodule ThemoviedbAlexa.Response.Rating.Behaviour do
  @moduledoc """
  Behavior that defines a response for a movie rating
  """

  alias Themoviedb.MovieInfo

  @type movie_rating :: map

  @callback response_movie_rating(MovieInfo) :: movie_rating
end
