defmodule ElixirDropbox do
  use HTTPoison.Base

  @type response :: {any}

  @base_url Application.get_env(:elixir_dropbox, :base_url)
  @upload_url Application.get_env(:elixir_dropbox, :upload_url)

  def post(client, url, body \\ "") do
    headers = json_headers
    post_request(client, "#{@base_url}#{url}", body, headers)
  end

  @spec upload_response(HTTPoison.Response.t) :: response
  def upload_response(%HTTPoison.Response{status_code: 200, body: body}), do: Poison.decode!(body)
  def upload_response(%HTTPoison.Response{status_code: status_code, body: body }) do
    cond do
    status_code in 400..599 ->
    #          %ElixirDropbox.Error{status: elem(JSON.decode(body), 0), status_code: status_code, summary: elem(JSON.decode(body), 1)}
    #        {:error, {{:http_status, status_code}, JSON.decode(body)}}
           {:error, {{:status_code, status_code}, JSON.decode(body)}}
    end
  end

   @spec download_response(HTTPoison.Response.t) :: response
   def download_response(response) do
    case response do
      {:ok, %{body: body, headers: headers, status_code: 200}} ->
        {:ok, %{file: body, headers: get_header(headers, "dropbox_api_result") |> Poison.decode}}
      _-> response
    end
  end

  def post_request(client, url, body, headers) do
    headers = Map.merge(headers, headers(client))
    HTTPoison.post!(url, body, headers) |> upload_response
  end

  def headers(client) do
    %{ "Authorization" => "Bearer #{client.access_token}" }
  end

  def json_headers do
    %{ "Content-Type" => "application/json" }
  end

  def get_header(headers, key) do
    headers
    |> Enum.filter(fn({k, _}) -> k == key end)
    |> hd
    |> elem(1)
  end
  
  def upload_request(client, url, data, headers) do
    post_request(client, "#{@upload_url}#{url}", {:file, data}, headers)
  end

  def download_request(client, url, data, headers) do
    headers = Map.merge(headers, headers(client))
    HTTPoison.post!("#{@upload_url}#{url}", data, headers) |> download_response
  end
end
