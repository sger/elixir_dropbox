defmodule ElixirDropbox.Paper.Users do
 import ElixirDropbox

 @doc """
 Allows an owner or editor to add users to a Paper doc or change their permissions using their email address or Dropbox account ID.

 ## Example

   members = [%{ "member" => %{ ".tag" => "email", "email" => "test@test.com" }, "permission_level": "view_and_comment" } ]
   ElixirDropbox.Paper.Users.add client, "HAOV9lRfMNj90iGLqMmC7", members, "", false

 More info at: https://www.dropbox.com/developers/documentation/http/documentation#paper-docs-users-add
 """
 def add(client, doc_id, members, custom_message, quiet) do
   body = %{"doc_id" => doc_id, "members" => members, "custom_message" => custom_message, "quiet" => quiet}
   result = to_string(Poison.Encoder.encode(body, []))
   post(client, "/paper/docs/users/add", result)
 end

 @doc """
 Lists all users who visited the Paper doc or users with explicit access.

 ## Example

   ElixirDropbox.Paper.Users.list client, "HAOV9lRfMNj90iGLqMmC7"

 More info at: https://www.dropbox.com/developers/documentation/http/documentation#paper-docs-users-list
 """
 def list(client, doc_id, limit \\ 100, filter_by \\ "shared") do
   body = %{"doc_id" => doc_id, "limit" => limit, "filter_by" => filter_by}
   result = to_string(Poison.Encoder.encode(body, []))
   post(client, "/paper/docs/users/list", result)
 end

 @doc """
 Once a cursor has been retrieved from docs/users/list, use this to paginate through all users on the Paper doc.

 ## Example

   ElixirDropbox.Paper.Users.list_continue client, "HAOV9lRfMNj90iGLqMmC7"

 More info at: https://www.dropbox.com/developers/documentation/http/documentation#paper-docs-users-list-continue
 """
 def list_continue(client, doc_id, cursor) do
   body = %{"doc_id" => doc_id, "cursor" => cursor}
   result = to_string(Poison.Encoder.encode(body, []))
   post(client, "/paper/docs/users/continue", result)
 end

 @doc """
 Allows an owner or editor to remove users from a Paper doc using their email address or Dropbox account ID.

 ## Example

   member = %{ "member" => %{ ".tag" => "email", "email" => "test@test.com" }
   ElixirDropbox.Paper.Users.remove client, "", member

 More info at: https://www.dropbox.com/developers/documentation/http/documentation#paper-docs-users-remove
 """
 def remove(client, doc_id, member) do
   body = %{"doc_id" => doc_id, "member" => member}
   result = to_string(Poison.Encoder.encode(body, []))
   post(client, "/paper/docs/users/remove", result)
 end
end
