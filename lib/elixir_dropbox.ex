defmodule ElixirDropbox do
  use HTTPoison.Base

  @dropbox_url Application.get_env(:elixir_dropbox, :dropbox_url)
  @access_token [{"Authorization", "Bearer #{Application.get_env(:elixir_dropbox, :access_token)}"}]

  def process_url(url) do
    api_url <> url
  end

  defp api_url do
    "#{@dropbox_url}"
  end

  def post(client, path, body \\ "") do
    headers = %{ "Content-Type" => "application/json"}
    do_request(client, :post, path, body, headers)
  end

  def process_response(%HTTPoison.Response{status_code: 200, body: body}), do: Poison.decode!(body)

  def process_response(%HTTPoison.Response{status_code: status_code, body: body }) do
    cond do
    status_code in 400..599 ->
      {:error, {{:http_status, status_code}, body}}
    end
  end

  def do_request(client, method, url, body \\ "", headers \\ [], options \\ []) do
      headers = Map.merge(headers, headers(client))
      request!(method, url, body, headers, options) |> process_response
  end

  # updates upload

   def upload_url do
     "https://content.dropboxapi.com/2/"
   end

   def headers(client) do
    %{ "Authorization" => "Bearer #{client.token}" }
   end

   def upload_request(client, url, data, headers) do
    headers = Map.merge(headers, headers(client))
    HTTPoison.post!("#{upload_url}#{url}", {:file, data}, headers) |> process_response
  end
end
