defmodule ElixirDropbox do
  use HTTPoison.Base
  alias ElixirDropbox.Client

	@dropbox_url Application.get_env(:elixir_dropbox, :dropbox_url)
	@access_token [{"Authorization", "Bearer #{Application.get_env(:elixir_dropbox, :access_token)}"}]

    def process_url(url) do
      api_url <> url
    end

    defp api_url do
      "#{@dropbox_url}"
    end
    

	def current_account do
		do_request(:post,  "/users/get_current_account")
    # working
		#|> handle_response	
	end

  def current_account_test do
    json_request(:post,  "/users/get_current_account")
 
  end

	def handle_response({:ok, %{status_code: 200, body: body}}) do
    	{ :ok, Poison.Parser.parse!(body) }
    	decode_as_account body
  	end

  	defp decode_as_account(body) do
  		Poison.decode body, as: ElixirDropbox.Account
	end

  	def handle_response({_, %{status_code: ___, body: body}}) do
    	{ :error, Poison.Parser.parse!(body) }
  	end

 def post(path, body \\ "") do
    json_request(:post,  path)
 end

    def process_response(%HTTPoison.Response{status_code: 200, body: body}), do: body
   def process_response(%HTTPoison.Response{status_code: status_code, body: body }), do: { status_code, body }

   def json_request(method, url, body \\ "", headers \\ [], options \\ []) do
    do_request(method, url, JSX.encode!(body), headers, options)
  end

  	defp do_request(method, url, body \\ "", headers \\ [], options \\ []) do
  		headers = [{"Authorization", "Bearer #{Application.get_env(:elixir_dropbox, :access_token)}"}]

  		case body do
      		{:json, json} ->
          headers = [{"Content-Type", "application/json"} | headers]
        	body = Poison.Encoder.encode json
      		{:file, _path} -> true
      			_ -> body = []
    	end

    	request!(method, url, body, headers, options) |> process_response
   	end
end
