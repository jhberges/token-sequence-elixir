defmodule TokSeq do
	use Urna
	require Logger

	def start_link do
		Logger.info("TokSeq initialized");
	end

	namespace :tokenseq do
		resource :next do
			post do
				token = params["token"]
				Logger.info("Next for #{token} with User-Agent '#{headers |> Dict.get("User-Agent")}'")
				send Process.whereis(:redis_facade), {:token, token, self()}
				receive do
					next ->
						%{next: next}
				end
			end
		end
	end
end
