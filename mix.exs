defmodule TokSeq.Mixfile do
  use Mix.Project

  def project do
    [app: :token_sequence,
     version: "0.1.0",
     elixir: "~> 1.7",
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [ registered: [:boot, TokSeq.Api],
      applications: [:logger, :eredis, :cauldron, :urna],
      mod: {Boot, []}
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
	    {:exrm, "~> 0.15.3"},
    	{:exredis, ">= 0.1.1"},
        {:cauldron, "~> 0.1"},
    	{:urna, ">= 0.2.5"},
      {:mixunit, "~> 0.9.2"}
    ]
  end
end
