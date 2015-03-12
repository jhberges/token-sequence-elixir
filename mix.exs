defmodule TokSeq.Mixfile do
  use Mix.Project

  def project do
    [app: :token_sequence,
     version: "0.0.1",
     elixir: "~> 1.0",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [ registered: [:boot, :redis_server, :redis_facade, :urna_pid],
      applications: [:logger],
      mod: {Boot, []}]
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
    	{:exredis, ">= 0.1.1"},
    	{:urna, ">= 0.1.4"}
    ]
  end
end