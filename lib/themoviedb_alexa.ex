defmodule ThemoviedbAlexa do
  @moduledoc """
  Documentation for ThemoviedbAlexa.
  """

  require Logger
  alias ThemoviedbAlexa.Request.{MovieRating, Launch}

  @doc """
  Entrypoint of the lambda function
  """
  def handle(
        lambda_request = %{"request" => request},
        lambda_context
      ) do
    Logger.debug(inspect(lambda_request))
    Logger.debug(inspect(lambda_context))

    request
    |> start_session()
    |> handle_request()
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

  defp start_session(request) do
    locale = Map.get(request, "locale")

    ThemoviedbAlexa.Session.start_link(name: RequestSession)

    ThemoviedbAlexa.Session.language(RequestSession, locale)

    request
  end
end
