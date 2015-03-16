defmodule Boot do
  require TokSeq
  require RedisFacade
  require Logger
  @behaviour :application

  def start(_type, _args) do
    Logger.info("Starting! #{inspect _args}")
    supervisorPid = TokSeq.Supervisor.start_link
    Logger.info("Boot started -> #{inspect supervisorPid}")
    supervisorPid
  end

  def stop(_type) do
    #Exredis.stop(Process.whereis(:urna_pid))
  end
end
