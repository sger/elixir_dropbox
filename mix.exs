defmodule ElixirDropbox.Mixfile do
  use Mix.Project

  @description """
    Simple Elixir wrapper for the Dropbox v2 API
  """

  def project do
    [
      app: :elixir_dropbox,
      version: "0.0.8",
      elixir: "~> 1.3",
      name: "ElixirDropbox",
      description: @description,
      package: package(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test, "coveralls.detail": :test, "coveralls.post": :test],
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison]]
  end

  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:httpoison, "~> 1.5"},
      {:poison, "~> 1.5"},
      {:inch_ex, "~> 0.5", only: [:dev, :test]},
      {:json, "~> 0.3.0"},
      {:ex_doc, "~> 0.14", only: :dev, runtime: false},
      {:exvcr, "~> 0.10", only: :test},
      {:excoveralls, "~> 0.7", only: :test},
      {:credo, "~> 0.9.0-rc1", only: [:dev, :test], runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["Spiros Gerokostas"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/sger/elixir_dropbox"}
    ]
  end
end
