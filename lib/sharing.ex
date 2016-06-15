defmodule ElixirDropbox.Sharing do

  def create_shared_link do
    body = %{"path" => "/Dev", "short_url" => true}
    result = to_string(Poison.Encoder.encode(body, []))
    ElixirDropbox.post("/sharing/create_shared_link", result)
  end
end
