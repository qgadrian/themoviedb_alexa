defmodule ThemoviedbAlexa.Response.Rating.Behaviour do
  @moduledoc """
  Behaviour that defines a response for a movie rating
  """
  @type movie_rating :: map

  @callback response_movie_rating(Themoviedb.MovieInfo) :: movie_rating
end
