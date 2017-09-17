defmodule ElixirDropbox.Files.CopyBatch do
 import ElixirDropbox

 @doc """
 Copy multiple files or folders to different locations at once in the user's Dropbox.

 ## Example

   ElixirDropbox.Files.CopyBatch.copy_batch(client, "/Temp/", "/Tmp")

 More info at: https://www.dropbox.com/developers/documentation/http/documentation#files-copy_batch
 """
 def copy_batch(client, from_path, to_path, allow_shared_folder \\ false, autorename \\ false, allow_ownership_transfer \\ false) do
   body = %{"entries" => [%{"from_path" => from_path, "to_path" => to_path}],
                            "allow_shared_folder" => allow_shared_folder,
                            "autorename" => autorename,
                            "allow_ownership_transfer" => allow_ownership_transfer}
   result = to_string(Poison.Encoder.encode(body, []))
   post(client, "/files/copy_batch", result)
 end

 @doc """
 Copy multiple files or folders to different locations at once in the user's Dropbox.

 ## Example

   ElixirDropbox.Files.CopyBatch.check(client, "")

 More info at: https://www.dropbox.com/developers/documentation/http/documentation#files-copy_batch
 """
 def check(client, async_job_id) do
   body = %{"async_job_id" => async_job_id}
   result = to_string(Poison.Encoder.encode(body, []))
   post(client, "/files/copy_batch/check", result)
 end
end
