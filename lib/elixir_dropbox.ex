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

  def test(path, client, body \\ "") do
    IO.puts "#{client.access_token}"
  end

  def post(path, body \\ "") do
    do_request(:post, path, body)
  end

  @type response :: {integer, any} | :jsx.json_term

  #def process_response_body(""), do: nil
  #def process_response_body(body), do: JSX.decode!(body)

  def process_response(%HTTPoison.Response{status_code: 200, body: body}), do: Poison.decode!(body)
  def process_response(%HTTPoison.Response{status_code: status_code, body: body }), do: { status_code, body }

  def process_response(%HTTPoison.Response{status_code: status_code, body: body }) do
    case status_code do
      400..599 ->
        {:error, body}
      end
  end

  def json_request(method, url, body \\ "", headers \\ [], options \\ []) do
    do_request(method, url, JSX.encode!(body), headers, options)
  end

  def do_request(method, url, body \\ "", headers \\ [], options \\ []) do
  	  headers = [{"Authorization", "Bearer #{Application.get_env(:elixir_dropbox, :access_token)}"}]
      headers = [{"Content-Type", "application/json"} | headers]
      request!(method, url, body, headers, options) |> process_response
   	end
end
