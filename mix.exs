defmodule ThemoviedbAlexa.MixProject do
  use Mix.Project

  def project do
    [
      app: :themoviedb_alexa,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      elixirc_paths: elixirc_paths(Mix.env()),
      preferred_cli_env: [
        build_lambda: :lambda,
        package: :lambda
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.0.0", only: [:dev, :test], runtime: false},
      {:aws_lambda_elixir_runtime, "~> 0.1.0", only: [:lambda]},
      {:distillery, "~> 2.0"},
      {:tmdb, git: "git@github.com:qgadrian/elixir-tmdb.git"},
      {:mox, "~> 0.4", only: :test},
      {:stream_data, "~> 0.1", only: :test}
    ]
  end

  def aliases do
    [
      compile: ["compile --warnings-as-errors"],
      build_lambda: "gen_lambda_release",
      package: ["release", "bootstrap", "zip"]
    ]
  end
end
