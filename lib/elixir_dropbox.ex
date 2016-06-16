defmodule ElixirDropbox do
  use HTTPoison.Base

  @dropbox_url Application.get_env(:elixir_dropbox, :dropbox_url)
  @access_token [{"Authorization", "Bearer #{Application.get_env(:elixir_dropbox, :access_token)}"}]

  def post(client, url, body \\ "") do
    headers = json_headers
    post_request(client, "#{base_url}#{url}", body, headers)
  end

  def process_response(%HTTPoison.Response{status_code: 200, body: body}), do: Poison.decode!(body)

  def process_response(%HTTPoison.Response{status_code: status_code, body: body }) do
    cond do
    status_code in 400..599 ->
      {:error, {{:http_status, status_code}, body}}
    end
  end

  def post_request(client, url, body, headers) do
    headers = Map.merge(headers, headers(client))
    HTTPoison.post!(url, body, headers) |> process_response
  end

  def base_url do
    "https://api.dropboxapi.com/2/"
  end  

  def upload_url do
    "https://content.dropboxapi.com/2/"
  end

  def headers(client) do
    %{ "Authorization" => "Bearer #{client.access_token}" }
  end

  def json_headers do
    %{ "Content-Type" => "application/json" }
  end
  
  def upload_request(client, url, data, headers) do
    post_request(client, "#{upload_url}#{url}", {:file, data}, headers)
  end
end
