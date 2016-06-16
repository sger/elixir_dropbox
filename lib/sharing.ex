defmodule ElixirDropbox.Sharing do

  def create_shared_link(client) do
    body = %{"path" => "/Dev", "short_url" => true}
    result = to_string(Poison.Encoder.encode(body, []))
    ElixirDropbox.post(client, "/sharing/create_shared_link", result)
  end
end
