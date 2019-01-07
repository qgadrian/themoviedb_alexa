defmodule ThemoviedbAlexa.Themoviedb.Client.Behaviour do
  @type movie_name :: String.t()

  @type movie_rating :: non_neg_integer

  @callback rating(String.t()) :: {:ok, Themoviedb.MovieInfo}
end
