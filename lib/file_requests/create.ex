defmodule ElixirDropbox.FileRequests do
 import ElixirDropbox

 def get(client, id) do
   body = %{"id" => id,}
   result = to_string(Poison.Encoder.encode(body, []))
   post(client, "file_requests/get", result)
 end
end
