defmodule ThemoviedbAlexa.Response.Rating.Spanish do
  @moduledoc """
  Module that provides an Alexa response to an intent in the spanish.
  """

  alias Themoviedb.MovieInfo

  @behaviour ThemoviedbAlexa.Response.Rating.Behaviour

  @doc """
  Returns an Alexa skill response with the rating info of a movie
  """
  @impl true
  def response_movie_rating(%MovieInfo{related_movies: []} = movie_info) do
    %{
      "version" => "1.0",
      "response" => %{
        "outputSpeech" => %{
          "type" => "PlainText",
          "text" => "La nota de #{movie_info.name} es #{movie_info.rating}",
          "playBehavior" => "REPLACE_ENQUEUED"
        },
        "shouldEndSession" => true
      }
    }
  end

  @doc """
  Returns an Alexa skill response with the rating info of a movie plus information about the other movie matches
  """
  @impl true
  def response_movie_rating(%MovieInfo{related_movies: other_movie_matches} = movie_info) do
    other_movie_titles =
      other_movie_matches
      |> Enum.take(3)
      |> Enum.map(& &1.title)
      # |> Enum.map(fn movie -> "<lang xml:lang=\"#{movie.language}-US\">#{movie.name}</lang>" end)
      |> Enum.join(", ")

    %{
      "version" => "1.0",
      # "sessionAttributes" => %{
      # "key" => "value"
      # },
      "response" => %{
        "outputSpeech" => %{
          # "type" => "SSML",
          "type" => "PlainText",
          "text" =>
            "La nota de #{movie_info.name} es #{movie_info.rating}, sin embargo es posible que estés buscando otras películas que he encontrado, por ejemplo #{
              other_movie_titles
            }",
          # "ssml" =>
          # "<speak>La nota de #{movie_info.name} es #{movie_info.rating}, sin embargo he encontrado otras películas como #{
          # other_movie_titles
          # }</speak>",
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
