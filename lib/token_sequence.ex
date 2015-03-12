defmodule TokSeq do
	use Urna
	require Logger

	def start_link do
		Logger.info("TokSeq initialized");
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
