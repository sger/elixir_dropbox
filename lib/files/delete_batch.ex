defmodule ElixirDropbox.Files.DeleteBatch do
 import ElixirDropbox

 @doc """
 Delete multiple files/folders at once.

 ## Example
   path_entries = [ %{"path" => "/Temp1"}, %{"path" => "/Temp2" } ]
   ElixirDropbox.Files.DeleteBatch.delete_batch(client, path_entries)

 More info at: https://www.dropbox.com/developers/documentation/http/documentation#files-delete_batch
 """
 def delete_batch(client, path_entries) do
   body = %{"entries" => path_entries}
   result = to_string(Poison.Encoder.encode(body, []))
   post(client, "/files/delete_batch", result)
 end

 @doc """
 Returns the status of an asynchronous job for delete_batch. If success, it returns list of result for each entry.

 ## Example

   ElixirDropbox.Files.DeleteBatch.check(client, "")

 More info at: https://www.dropbox.com/developers/documentation/http/documentation#files-delete_batch-check
 """
 def check(client, async_job_id) do
   body = %{"async_job_id" => async_job_id}
   result = to_string(Poison.Encoder.encode(body, []))
   post(client, "/files/delete_batch/check", result)
 end
end
