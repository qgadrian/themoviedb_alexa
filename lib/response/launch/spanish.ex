defmodule ThemoviedbAlexa.Response.Launch.Spanish do
  @module """
  Module to build an spanish response for an Alexa skill launch request
  """

  @doc """
  Returns hint invoke commands for the Alexa skill
  """
  @spec launch_response() :: map
  def launch_response() do
    %{
      "version" => "1.0",
      "response" => %{
        "outputSpeech" => %{
          "type" => "PlainText",
          "text" =>
            "Puedes preguntarme la nota de la pelicula que quieras. Por ejemplo puedes decir, Alexa, dime la nota de Star Wars",
          "playBehavior" => "REPLACE_ENQUEUED"
        }
      }
    }
  end
end
