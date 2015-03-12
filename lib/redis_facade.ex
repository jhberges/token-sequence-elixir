defmodule RedisFacade do
  use Exredis
  require Logger

  def start_link do
    Logger.info("RedisFacade initialized");
  end

  def loop do
    Logger.debug("RedisFacade entering loop with #{inspect Process.whereis(:redis_server)}")
    receive do
      {:next, token, caller} ->
        send caller,  Process.whereis(:redis_server) |> Exredis.Api.incr(token)
        loop()
      {:current, token, caller} ->
        send caller,  Process.whereis(:redis_server) |> Exredis.Api.get(token)
        loop()
    end
  end
end
