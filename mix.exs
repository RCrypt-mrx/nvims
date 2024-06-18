defmodule Nvims.MixProject do
  use Mix.Project

  def project do
    [
      app: :nvims,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      # escript: [main_module: Nvims],
      releases: [
        demo: [
          include_executables_for: [:unix],
          applications: [
            runtime_tools: :permanent
          ]
        ]
      ],
      deps: [
        {:corsica, "~> 1.2"},
        {:poison, "~> 4.0"},
        {:plug, "~> 1.7"},
        {:cowboy, "~> 2.5"},
        {:plug_cowboy, "~> 2.0"},
        {:yaml_elixir, "~> 2.8.0"}
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Nvims.Application, []}
    ]
  end
end
