defmodule Themoviedb.Response.Spanish do
  @moduledoc """
  Module that provides the responses in the spanish language
  """

  defdelegate response_movie_rating(movie_info),
    to: ThemoviedbAlexa.Response.Rating.Spanish

  defdelegate launch_response(), to: ThemoviedbAlexa.Response.Launch.Spanish
end
