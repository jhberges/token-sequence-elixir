defmodule TokSeq.Supervisor do
  use Supervisor
  require Logger

  def start_link do
    Logger.info("TokSeq.Supervisor start_link")
    Supervisor.start_link(__MODULE__, :ok)
  end

  @api_name TokSeq.Api

  def init(:ok) do
    Logger.info("TokSeq.Supervisor init")
    children = [
      worker(TokSeq, [[name: @api_name]]),
      worker(Urna, [TokSeq, [port: Application.get_env(:token_sequence, :urna_http_port)]])
    ]

    result = supervise(children, strategy: :one_for_one)
    Logger.info("TokSeq.Supervisor init'ed -> #{inspect result}")
    result
  end
end
