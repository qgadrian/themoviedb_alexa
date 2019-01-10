defmodule ThemoviedbAlexa.SessionTest do
  use ExUnit.Case

  alias ThemoviedbAlexa.Session

  describe "Given a language" do
    test "when is set then the GenServer returns de langauge" do
      {:ok, pid} = Session.start_link()

      Session.language(pid, "lang")

      assert Session.language(pid) == "lang"
    end
  end
end
