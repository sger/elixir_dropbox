defmodule ElixirDropbox.Client do

	@dropbox_url Application.get_env(:elixir_dropbox, :dropbox_url)
	@access_token [{"Authorization", "Bearer #{Application.get_env(:elixir_dropbox, :access_token)}"}]
    
    def to_struct(kind, attrs) do
      struct = struct(kind)
      Enum.reduce Map.to_list(struct), struct, fn {k, _}, acc ->
        case Map.fetch(attrs, Atom.to_string(k)) do
          {:ok, v} -> %{acc | k => v}
          :error -> acc
        end
      end
    end

	def start do
          HTTPoison.start
	end

	def test_get do
	  HTTPoison.get! "http://httparrot.herokuapp.com/get"
	end

	def print_url do
	  IO.puts "#{@dropbox_url}"
	end

	def current_account do
		do_request(:post,  current_account_url)
		|> handle_response
	
	end

	def get_current_account do
		do_request(:post,  current_account_url)
	end

	def current_account_url do
		"#{@dropbox_url}/users/get_current_account"
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

  defp do_request(method, url, body \\ "") do
  	headers = [{"Authorization", "Bearer IV3n31frOYcAAAAAAAANQygXdWwyam2KMwZTvg8dPJH7bIIJ9lRGx5Fbw387jy1z"}]

  	case body do
      {:json, json} ->
        headers = [{"Content-Type", "application/json"} | headers]
        body = Poison.Encoder.encode json
      {:file, _path} -> true
      _ -> body = []
    end

    HTTPoison.request(method, url, body, headers) 
    	#|> handle_response
   end
  	
end
