defmodule ThemoviedbAlexa.Response.Behaviour do
  @type movie_rating :: map

  @type launch_request :: map

  @callback response_movie_rating(String.t(), non_neg_integer) :: movie_rating

  @callback launch_request() :: launch_request
end
