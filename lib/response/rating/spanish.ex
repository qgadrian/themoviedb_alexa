defmodule ThemoviedbAlexa.Response.Rating.Spanish do
  @moduledoc """
  Module that provides an Alexa response to an intent in the spanish.
  """

  @behaviour ThemoviedbAlexa.Response.Behaviour

  @doc """
  Returns an Alexa skill response with the rating info of a movie
  """
  @spec response_movie_rating(String.t(), non_neg_integer) :: map
  def response_movie_rating(movie_name, movie_rating) do
    %{
      "version" => "1.0",
      # "sessionAttributes" => %{
      # "key" => "value"
      # },
      "response" => %{
        "outputSpeech" => %{
          "type" => "PlainText",
          "text" => "La nota de #{movie_name} es #{movie_rating}",
          "playBehavior" => "REPLACE_ENQUEUED"
        },
        # "reprompt": {
        # "outputSpeech": {
        # "type": "PlainText",
        # "text": "Plain text string to speak",
        # "ssml": "<speak>SSML text string to speak</speak>",
        # "playBehavior": "REPLACE_ENQUEUED"
        # }
        # },
        "shouldEndSession" => true
      }
    }
  end
end
