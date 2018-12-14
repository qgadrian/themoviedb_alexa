defmodule ThemoviedbAlexa.Themoviedb.Client.Behaviour do
  @type movie_name :: String.t()

  @type movie_rating :: non_neg_integer

  @callback rating(String.t()) :: {:ok, movie_name, movie_rating}
end
