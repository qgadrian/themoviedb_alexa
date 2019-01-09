defmodule ThemoviedbAlexaTest do
  use ExUnit.Case
  doctest ThemoviedbAlexa

  import Mox

  alias Themoviedb.MovieInfo

  @context_request %{}

  @launch_request %{
    "request" => %{
      "locale" => "es-ES",
      "requestId" => "amzn1.echo-api.request",
      "shouldLinkResultBeReturned" => false,
      "timestamp" => "2018-12-15T14:16:17Z",
      "type" => "LaunchRequest"
    }
  }

  @movie_rating_request %{
    "context" => %{
      "System" => %{
        "apiAccessToken" => "fakeApiAccessToken",
        "apiEndpoint" => "https://api.eu.amazonalexa.com",
        "application" => %{
          "applicationId" => "amzn1.ask.skill"
        },
        "device" => %{
          "deviceId" => "amzn1.ask.device",
          "supportedInterfaces" => %{}
        },
        "user" => %{
          "userId" => "amzn1.ask.account"
        }
      },
      "Viewport" => %{
        "currentPixelHeight" => 600,
        "currentPixelWidth" => 1024,
        "dpi" => 160,
        "experiences" => [
          %{
            "arcMinuteHeight" => 144,
            "arcMinuteWidth" => 246,
            "canResize" => false,
            "canRotate" => false
          }
        ],
        "pixelHeight" => 600,
        "pixelWidth" => 1024,
        "shape" => "RECTANGLE",
        "touch" => ["SINGLE"]
      }
    },
    "request" => %{
      "dialogState" => "STARTED",
      "intent" => %{
        "confirmationStatus" => "NONE",
        "name" => "CheckRatingIntent",
        "slots" => %{
          "movie_name" => %{
            "confirmationStatus" => "NONE",
            "name" => "movie_name",
            "source" => "USER",
            "value" => "star wars a new hope"
          }
        }
      },
      "locale" => "es-ES",
      "requestId" => "amzn1.echo-api.request",
      "timestamp" => "2018-12-15T13:19:56Z",
      "type" => "IntentRequest"
    },
    "session" => %{
      "application" => %{
        "applicationId" => "amzn1.ask.skill"
      },
      "new" => true,
      "sessionId" => "amzn1.echo-api.session",
      "user" => %{
        "userId" => "amzn1.ask.account"
      }
    },
    "version" => "1.0"
  }

  describe "Given an intent request" do
    test "when it provides a movie name then the movie rating is returned" do
      movie_rating = 999

      expected_response = %{
        "version" => "1.0",
        "response" => %{
          "outputSpeech" => %{
            "type" => "PlainText",
            "playBehavior" => "REPLACE_ENQUEUED",
            "text" => "La nota de star wars a new hope es #{movie_rating}"
          },
          "shouldEndSession" => true
        }
      }

      :themoviedb_alexa
      |> Application.get_env(:tmdb_client)
      |> expect(:rating, fn movie_name ->
        {
          :ok,
          %MovieInfo{
            name: movie_name,
            rating: movie_rating,
            release_date: Date.utc_today()
          }
        }
      end)

      assert expected_response == ThemoviedbAlexa.handle(@movie_rating_request, @context_request)
    end

    test "when it provides a launch request then a launch response is provided" do
      expected_response = %{
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

      assert expected_response == ThemoviedbAlexa.handle(@launch_request, @context_request)
    end
  end
end
