defmodule Hotlap.MixProject do
  use Mix.Project

  def project do
    [
      app: :hotlap,
      version: "1.0.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.html": :test,
        "coveralls.json": :test,
      ],
      test_coverage: [tool: ExCoveralls],
      deps: deps(),

      # Docs
      name: "Hotlap",
      source_url: "https://github.com/pr0grammr/hotlap"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.21", only: :dev, runtime: false},
      {:excoveralls, "~> 0.5.7", only: :test}
    ]
  end
end
