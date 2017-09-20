defmodule ElixirDropbox.FileRequests do
 import ElixirDropbox

 @doc """
 Creates a file request for this user.

 ## Example
   deadline = %{ "deadline" => "2020-10-12T17:00:00Z" }
   ElixirDropbox.FileRequests.create client , "cool", "/Temp", deadline

 More info at: https://www.dropbox.com/developers/documentation/http/documentation#file_requests-create
 """
 def create(client, title, destination, deadline, open \\ true) do
   body = %{"title" => title, "destination" => destination, "deadline" => deadline, "open" => open}
   result = to_string(Poison.Encoder.encode(body, []))
   post(client, "/file_requests/create", result)
 end

 @doc """
 Returns the specified file request.

 ## Example
   ElixirDropbox.FileRequests.get client , ""

 More info at: https://www.dropbox.com/developers/documentation/http/documentation#file_requests-get
 """
 def get(client, id) do
   body = %{"id" => id,}
   result = to_string(Poison.Encoder.encode(body, []))
   post(client, "/file_requests/get", result)
 end

 @doc """
 Returns a list of file requests owned by this user.
 For apps with the app folder permission, this
 will only return file requests with
 destinations in the app folder.

 ## Example
   ElixirDropbox.FileRequests.list client

 More info at: https://www.dropbox.com/developers/documentation/http/documentation#file_requests-list
 """
 def list(client) do
   post(client, "/file_requests/list", "null")
 end

 @doc """
 Update a file request.

 ## Example
   deadline = %{ "deadline" => "2020-10-12T17:00:00Z" }
   ElixirDropbox.FileRequests.create client, "", "cool", "/Temp", deadline

 More info at: https://www.dropbox.com/developers/documentation/http/documentation#file_requests-list
 """
 def update(client, id, title, destination, deadline, open \\ true) do
   body = %{"id" => id, "title" => title, "destination" => destination, "deadline" => deadline, "open" => open}
   result = to_string(Poison.Encoder.encode(body, []))
   post(client, "/file_requests/update", result)
 end
end
