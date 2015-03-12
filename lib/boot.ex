defmodule Boot do
  require TokSeq
  require RedisFacade
  require Logger
  @behaviour :application

  def start do
    Logger.info("Starting - Exredis")
    redisPid = Exredis.start
    Logger.info("Starting - Exredis - regging #{inspect redisPid}")
    Process.register(redisPid, :redis_server)

    Logger.info("Starting - RedisFacade")
    {redisFacadePid, _} = Process.spawn(RedisFacade, :loop, [], [:link, :monitor])
    Logger.info("Starting - RedisFacade - regging #{inspect redisFacadePid}")
    Process.register(redisFacadePid, :redis_facade)

    Logger.info("Starting - Urna")
    {:ok, urnaPid} = Urna.start TokSeq, port: 9000
    Logger.info("Starting - Urna - regging #{inspect urnaPid}")
    Process.register(urnaPid, :urna_pid)
    Logger.info("Started")
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
