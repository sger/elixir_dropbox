defmodule ElixirDropbox.Sharing do

  def create_shared_link(client, path) do
    body = %{"path" => path, "short_url" => true}
    result = to_string(Poison.Encoder.encode(body, []))
    ElixirDropbox.post(client, "/sharing/create_shared_link", result)
  end
end
