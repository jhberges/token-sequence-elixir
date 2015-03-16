defmodule RedisFacade do
  use Exredis
  require Logger

  def start_link([name: name]) do
    Logger.info("""
    Starting Exredis:
      - host: #{Application.get_env(:token_sequence, :redis_hostname)}
      - port: #{Application.get_env(:token_sequence, :redis_port)}
      - db# : #{Application.get_env(:token_sequence, :redis_database)},
      - pass: #{Application.get_env(:token_sequence, :redis_password)}
    """)
    {:ok, exredisPid} = Exredis.start_link(
      Application.get_env(:token_sequence, :redis_hostname),
      Application.get_env(:token_sequence, :redis_port),
      Application.get_env(:token_sequence, :redis_database),
      Application.get_env(:token_sequence, :redis_password)
    )
    Logger.info("RedisFacade initialized -- Exredis is at #{inspect exredisPid}")
    Task.start_link( fn -> loop(exredisPid) end )
  end

  defp loop(exredisPid) do
    Logger.debug("RedisFacade entering loop with #{inspect exredisPid}")
    receive do
      {:init, exredisPid} ->
        loop(exredisPid)
      {:next, token, caller} ->
        send caller,  exredisPid |> Exredis.Api.incr(token)
        loop(exredisPid)
      {:current, token, caller} ->
        Logger.debug("Current for #{URI.decode(token)}")
        value = exredisPid |> Exredis.Api.get(URI.decode(token))
        Logger.debug("Current for #{URI.decode(token)} is #{value}")
        send caller,  value
        loop(exredisPid)
    end
  end
end
