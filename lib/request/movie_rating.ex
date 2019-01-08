defmodule ThemoviedbAlexa.Request.MovieRating do
  @moduledoc """
  Module to handle a request for a Movie rating
  """

  require Logger

  alias Themoviedb.Response.Spanish

  @intent_name "CheckRatingIntent"
  @slot_movie_name "movie_name"

  @doc """
  Handles a lambda request and delegates the Alexa response to each locale supported
  """
  @spec handle_request(map) :: map
  def handle_request(request = %{"intent" => intent = %{"name" => @intent_name}}) do
    with locale <- Map.get(request, "locale"),
         slots <- Map.get(intent, "slots"),
         slot_movie_name <- Map.get(slots, @slot_movie_name),
         movie_name <- Map.get(slot_movie_name, "value") do
      Logger.info(fn -> "Language request | #{locale}" end)
      Logger.info(fn -> "Rating request | #{movie_name}" end)

      {:ok, movie_info} =
        :themoviedb_alexa
        |> Application.get_env(:tmdb_client)
        |> Kernel.apply(:rating, [movie_name])

      response =
        case locale do
          "es-ES" ->
            Spanish.response_movie_rating(movie_info)
        end

      Logger.debug(inspect(response))

      response
    end
  end
end
