defmodule Boot do
  require TokSeq
  require RedisFacade
  require Logger
  require Mix.Config
  @behaviour :application

  def start do
    config = Mix.Config.read!("config/config.exs")
    Logger.info("Starting - Exredis")
    redisPid = Exredis.start(config[:redis][:hostname], config[:redis][:port], config[:redis][:database], config[:redis][:password])
    Logger.info("Starting - Exredis - regging #{inspect redisPid}")
    Process.register(redisPid, :redis_server)

    Logger.info("Starting - RedisFacade")
    {redisFacadePid, _} = Process.spawn(RedisFacade, :loop, [], [:link, :monitor])
    Logger.info("Starting - RedisFacade - regging #{inspect redisFacadePid}")
    Process.register(redisFacadePid, :redis_facade)

    Logger.info("Starting - Urna")
    {:ok, urnaPid} = Urna.start TokSeq, port: config[:urna][:http_port]
    Logger.info("Starting - Urna - regging #{inspect urnaPid}")
    Process.register(urnaPid, :urna_pid)
  end

  def start(_type, _args) do
    Logger.info("Starting!")
    start()
    Logger.info("Starting - done")
    {:ok, self()}
  end

  def stop(_type) do
    Exredis.stop(Process.whereis(:urna_pid))
  end
end
