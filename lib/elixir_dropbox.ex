defmodule ElixirDropbox do
  @moduledoc """
  ElixirDropbox is a wrapper for Dropbox API V2
  """
  use HTTPoison.Base

  @base_url Application.get_env(:elixir_dropbox, :base_url)

  def post(client, url, body \\ "") do
    headers = json_headers()
    post_request(client, "#{@base_url}#{url}", body, headers)
  end

  def post_url(client, base_url, url, body \\ "") do
    headers = json_headers()
    post_request(client, "#{base_url}#{url}", body, headers)
  end

  @spec process_response(HTTPoison.Response.t()) :: response
  def process_response(%HTTPoison.Response{status_code: 200, body: body}), do: Poison.decode!(body)

  def process_response(%HTTPoison.Response{status_code: status_code, body: body}) do
    cond do
      status_code in 400..599 ->
        {{:status_code, status_code}, JSON.decode(body)}
    end
  end

  @spec download_response(HTTPoison.Response.t()) :: response
  def download_response(%HTTPoison.Response{status_code: 200, body: body, headers: headers}),
    do: %{body: body, headers: headers}

  def download_response(%HTTPoison.Response{status_code: status_code, body: body}) do
    cond do
      status_code in 400..599 ->
        {{:status_code, status_code}, JSON.decode(body)}
    end
  end

  def post_request(client, url, body, headers) do
    headers = Map.merge(headers, headers(client))
    IO.inspect headers
    IO.inspect url
    IO.inspect body
    HTTPoison.post!(url, body, headers) |> process_response
  end

  def upload_request(client, base_url, url, data, headers) do
    post_request(client, "#{base_url}#{url}", {:file, data}, headers)
  end

  def download_request(client, base_url, url, data, headers) do
    headers = Map.merge(headers, headers(client))
    HTTPoison.post!("#{base_url}#{url}", data, headers) |> download_response
  end

  def headers(client) do
    %{"Authorization" => "Bearer #{client.access_token}"}
  end

  def json_headers do
    %{"Content-Type" => "application/json"}
  end
end
