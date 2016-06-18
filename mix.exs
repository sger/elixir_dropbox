defmodule ElixirDropbox.Mixfile do
  use Mix.Project
  
  @description """
    Simple Elixir wrapper for the Dropbox v2 API
  """

  def project do
    [app: :elixir_dropbox,
     version: "0.0.1",
     elixir: "~> 1.2",
     name: "ElixirDropbox",
     description: @description,
     package: package,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison, :exjsx]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      { :httpoison, "~> 0.8" },
      { :poison, "~> 1.5" },
      { :exjsx, "~> 3.2" },
      { :inch_ex, "~> 0.5", only: [:dev, :test] },
      { :json, "~> 0.3.0" }
    ]
  end

  defp package do
    [mainteners: ["Spiros Gerokostas"],
     licences: ["MIT"],
     links: %{ "GitHub" => "https://github.com/sger/elixir_dropbox" }]
  end
end
