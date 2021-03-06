defmodule TokSeq do
	use Urna
	require Logger

	def start_link([name: theName]) do
		{:ok, redisFacadePid} = RedisFacade.start_link([name: ""])
		Process.register(redisFacadePid, :redis_facade) # Should've used GenServer for this, so that logical local names could have been used.
		{:ok, self()}
	end

	namespace :tokenseq do
		resource :cur do
			get token do
				send Process.whereis(:redis_facade), {:current, token, self()}
				receive do
					value ->
						%{seq: value}
				end
			end
		end

		resource :next do
			post do
				token = params["token"]
				Logger.info("Next for #{token} with User-Agent '#{headers |> Dict.get("User-Agent")}'")
				send Process.whereis(:redis_facade), {:next, token, self()}
				receive do
					next ->
						%{seq: next}
				end
			end
		end
	end
end
