defmodule StartApp.Mixfile do
  use Mix.Project

  def project do
    [app: :startapp,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: []]
  end

  def application do
    [extra_applications: [:logger]]
  end
end
