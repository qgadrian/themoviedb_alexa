defmodule ThemoviedbAlexa.Request.Launch do
  @moduledoc """
  Module to handle Launch request for an Alexa skill
  """
  require Logger

  alias Themoviedb.Response.Spanish

  def handle_request(request = %{"type" => "LaunchRequest"}) do
    with locale <- Map.get(request, "locale") do
      Logger.info(fn -> "Language request | #{locale}" end)
      Logger.info(fn -> "Launch request" end)

      case locale do
        "es-ES" ->
          Spanish.launch_response()
      end
    end
  end
end
