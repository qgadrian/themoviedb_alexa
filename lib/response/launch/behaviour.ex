defmodule ThemoviedbAlexa.Response.Launch.Behaviour do
  @moduledoc """
  Module that defines the response behaviour for a launch request
  """

  @type launch_response :: map

  @callback launch_response() :: launch_response
end
