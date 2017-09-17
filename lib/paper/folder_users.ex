defmodule ElixirDropbox.Paper.FolderUsers do
 import ElixirDropbox

 @doc """
 Lists the users who are explicitly invited to the Paper folder in which the Paper doc is contained.

 ## Example

   ElixirDropbox.Paper.FolderUsers.list client, "HAOV9lRfMNj90iGLqMmC7"

 More info at: https://www.dropbox.com/developers/documentation/http/documentation#paper-docs-folder_users-list
 """
 def list(client, doc_id, limit \\ 100) do
   body = %{"doc_id" => doc_id, "limit" => limit}
   result = to_string(Poison.Encoder.encode(body, []))
   post(client, "/paper/docs/folder_users/list", result)
 end

 @doc """
 Once a cursor has been retrieved from docs/folder_users/list, use this to paginate through all users on the Paper folder.

 ## Example

   ElixirDropbox.Paper.FolderUsers.list_continue client, "HAOV9lRfMNj90iGLqMmC7", "AAuZ7AfEqob4EmNB0cmklBTgrtWTp/CYxfGDT/NF+eIOFBHicsClvbNxwo4mOkM9rcH8wjG/YH5We/RoYi5E42aJZ10PioyyeaamVJKsNpjoskFQx8FLwN0fLuJypnownrfowttiP7DSeahX+8eSZHCdhYbHgqTX8F4pVDY603amLDyVd6dCtxFwk+h+iCWAuAetCHBqmY3a6PVWHwXYgnpT/8NcDXkD08CkKEO798Y3de6l8RN5I5xFh5QK2sNCIsXA8NOL+g8TmejjwTYQ3YAa"

 More info at: https://www.dropbox.com/developers/documentation/http/documentation#paper-docs-folder_users-list-continue
 """
 def list_continue(client, doc_id, cursor) do
   body = %{"doc_id" => doc_id, "cursor" => cursor}
   result = to_string(Poison.Encoder.encode(body, []))
   post(client, "/paper/docs/folder_users/list/continue", result)
 end
end
