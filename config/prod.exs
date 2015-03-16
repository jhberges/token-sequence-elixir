use Mix.Config
config :logger, :console,
  level: :warn,
  format: "$date $time [$level] $metadata$message\n",
  metadata: [:user_id]
