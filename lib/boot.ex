defmodule Boot do
  require TokSeq
  require RedisFacade
  require Logger
  @behaviour :application

  # def start do
  #   Logger.info("Starting - Exredis: #{inspect Application.get_env(:token_sequence, :redis_hostname)}")
  #   {_, redisPid} = Exredis.start(
  #     Application.get_env(:token_sequence, :redis_hostname),
  #     Application.get_env(:token_sequence, :redis_port),
  #     Application.get_env(:token_sequence, :redis_database),
  #     Application.get_env(:token_sequence, :redis_password))
  #   Logger.info("Starting - Exredis - regging #{inspect redisPid}")
  #   Process.register(redisPid, :redis_server)
  #
  #   Logger.info("Starting - RedisFacade")
  #   {redisFacadePid, _} = Process.spawn(RedisFacade, :loop, [], [:link, :monitor])
  #   Logger.info("Starting - RedisFacade - regging #{inspect redisFacadePid}")
  #   Process.register(redisFacadePid, :redis_facade)
  #
  #   Logger.info("Starting - Urna")
  #   {:ok, urnaPid} = Urna.start TokSeq, port: Application.get_env(:token_sequence, :urna_http_port)
  #   Logger.info("Starting - Urna - regging #{inspect urnaPid}")
  #   Process.register(urnaPid, :urna_pid)
  #   {:ok, self()}
  # end

  def start(_type, _args) do
    Logger.info("Starting! #{inspect _args}")
#    start()
    #Logger.info("Starting - done")
    #{:ok, self()}
    TokSeq.Supervisor.start_link
  end

  def stop(_type) do
    #Exredis.stop(Process.whereis(:urna_pid))
  end
end
