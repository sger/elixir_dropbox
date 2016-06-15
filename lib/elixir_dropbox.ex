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

  def process_response(%HTTPoison.Response{status_code: 200, body: body}), do: Poison.decode!(body)

  def process_response(%HTTPoison.Response{status_code: status_code, body: body }) do
    cond do
    status_code in 400..599 ->
      {:error, {{:http_status, status_code}, body}}
    end
  end

  def do_request(method, url, body \\ "", headers \\ [], options \\ []) do
      headers = [{"Authorization", "Bearer #{Application.get_env(:elixir_dropbox, :access_token)}"}]
      headers = [{"Content-Type", "application/json"} | headers]
      request!(method, url, body, headers, options) |> process_response
  end
end
