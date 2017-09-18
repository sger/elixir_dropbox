defmodule ElixirDropbox.Files.CopyReference do
 import ElixirDropbox

 @doc """
 Get a copy reference to a file or folder.
 This reference string can be used to save that file or
 folder to another user's Dropbox by passing it to copy_reference/save.

 ## Example

   ElixirDropbox.Files.CopyReference.get(client, "")

 More info at: https://www.dropbox.com/developers/documentation/http/documentation#files-copy_reference-get
 """
 def get(client, path) do
   body = %{"path" => path}
   result = to_string(Poison.Encoder.encode(body, []))
   post(client, "/files/copy_reference/get", result)
 end

 @doc """
 Save a copy reference returned by copy_reference/get to the user's Dropbox.

 ## Example

   ElixirDropbox.Files.CopyReference.get(client, "", "")

 More info at: https://www.dropbox.com/developers/documentation/http/documentation#files-copy_reference-save
 """
 def save(client, copy_reference, path) do
   body = %{"copy_reference" => copy_reference, "path" => path}
   result = to_string(Poison.Encoder.encode(body, []))
   post(client, "/files/copy_reference/save", result)
 end
end
