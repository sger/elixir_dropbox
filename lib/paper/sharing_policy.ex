defmodule ElixirDropbox.Paper.SharingPolicy do
 import ElixirDropbox

 @doc """
 Gets the default sharing policy for the given Paper doc.

 ## Example

   ElixirDropbox.Paper.SharingPolicy.get client, ""

 More info at: https://www.dropbox.com/developers/documentation/http/documentation#paper-docs-sharing_policy-get
 """
 def get(client, doc_id) do
   body = %{"doc_id" => doc_id}
   result = to_string(Poison.Encoder.encode(body, []))
   post(client, "/paper/docs/sharing_policy/get", result)
 end

 @doc """
 Sets the default sharing policy for the given Paper doc.

 ## Example

   ElixirDropbox.Paper.SharingPolicy.set client, "HAOV9lRfMNj90iGLqMmC7", sharing_policy
 More info at: https://www.dropbox.com/developers/documentation/http/documentation#paper-docs-sharing_policy-set
 """
 def set(client, doc_id, sharing_policy) do
   body = %{"doc_id" => doc_id, "sharing_policy" => sharing_policy}
   result = to_string(Poison.Encoder.encode(body, []))
   post(client, "/paper/docs/sharing_policy/set", result)
 end
end
