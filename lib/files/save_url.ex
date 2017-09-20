defmodule ElixirDropbox.Files.SaveUrl do
 import ElixirDropbox

 @doc """
 Save a specified URL into a file in user's Dropbox.

 ## Example

   ElixirDropbox.Files.SaveUrl.save_url(client, "/a.txt", "http://example.com/a.txt")

 More info at: https://www.dropbox.com/developers/documentation/http/documentation#files-save_url
 """
 def save_url(client, path, url) do
   body = %{"path" => path, "url" => url}
   result = to_string(Poison.Encoder.encode(body, []))
   post(client, "/files/save_url", result)
 end

 @doc """
 Check the status of a save_url job.

 ## Example

   ElixirDropbox.Files.SaveUrl.check_job_status(client, "34g93hh34h04y384084")

 More info at: https://www.dropbox.com/developers/documentation/http/documentation#files-save_url
 """
 def check_job_status(client, async_job_id) do
   body = %{"async_job_id" => async_job_id}
   result = to_string(Poison.Encoder.encode(body, []))
   post(client, "/files/save_url/check_job_status", result)
 end
end
