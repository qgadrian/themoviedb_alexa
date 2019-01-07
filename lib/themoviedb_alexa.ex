defmodule ThemoviedbAlexa do
  @moduledoc """
  Documentation for ThemoviedbAlexa.
  """

  require Logger
  alias ThemoviedbAlexa.Request.{MovieRating, Launch}

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

  @spec handle_request(map) :: map
  defp handle_request(request = %{"intent" => %{"name" => "CheckRatingIntent"}}) do
    MovieRating.handle_request(request)
  end

  defp handle_request(request = %{"type" => "LaunchRequest"}) do
    Launch.handle_request(request)
  end

  def themoviedb_handler(request) do
    Logger.error(inspect(request))
  end
end
