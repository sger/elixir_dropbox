defmodule APICall do
	use HTTPoison.Base

	@dropbox_url Application.get_env(:elixir_dropbox, :dropbox_url)

	def process_url(url) do
    	api_url <> url
  	end
  	
  	def process_request_headers(headers) do	
    	[{"Authorization", "Bearer #{Application.get_env(:elixir_dropbox, :access_token)}"}, {"Content-Type", "application/json"} | headers]
  	 end

  	defp api_url do
    	"#{@dropbox_url}"
  	end
end
