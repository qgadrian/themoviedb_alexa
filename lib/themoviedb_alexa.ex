defmodule ThemoviedbAlexa do
  @moduledoc """
  Documentation for ThemoviedbAlexa.
  """

  require Logger
  alias ThemoviedbAlexa.Response.{Spanish}

  @tmdb_client Application.get_env(:themoviedb_alexa, :tmdb_client)

  @doc """
  Entrypoint of the lambda function
  """
  def themoviedb_handler(
        lambda_request = %{"request" => request},
        lambda_context
      ) do
    Logger.debug(inspect(lambda_request))
    Logger.debug(inspect(lambda_context))

    handle_request(request)
  end

  @doc """
  Handles a lambda request and delegates the Alexa response to each locale supported
  """
  @spec handle_request(map) :: map
  defp handle_request(request = %{"intent" => intent = %{"name" => "CheckRatingIntent"}}) do
    with locale <- Map.get(request, "locale"),
         slots <- Map.get(intent, "slots"),
         slot_movie_name <- Map.get(slots, "movie_name"),
         movie_name <- Map.get(slot_movie_name, "value") do
      Logger.info(fn -> "Language request | #{locale}" end)
      Logger.info(fn -> "Rating request | #{movie_name}" end)

      {:ok, movie_name, movie_rating} = @tmdb_client.rating(movie_name)

      case locale do
        "es-ES" ->
          Spanish.response_movie_rating(movie_name, movie_rating)
      end
    end
  end

  defp handle_request(request = %{"type" => "LaunchRequest"}) do
    with locale <- Map.get(request, "locale") do
      Logger.info(fn -> "Language request | #{locale}" end)
      Logger.info(fn -> "Launch request" end)

      case locale do
        "es-ES" ->
          Spanish.launch_request()
      end
    end
  end

  def themoviedb_handler(request) do
    Logger.error(inspect(request))
  end
end
