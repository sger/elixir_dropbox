defmodule ElixirDropbox.Files.UploadSession do
 import ElixirDropbox

 @doc """
 Upload sessions allow you to upload a single file in one or more requests,
 for example where the size of the file is greater than 150 MB.

 ## Example

   ElixirDropbox.Files.UploadSession.start(client, false, "/Tmp")

 More info at: https://www.dropbox.com/developers/documentation/http/documentation#files-upload_session-start
 """
 def start(client, close, file) do
   dropbox_headers = %{
     :close => close
   }
   headers = %{ "Dropbox-API-Arg" => Poison.encode!(dropbox_headers), "Content-Type" => "application/octet-stream" }
   upload_request(client, Application.get_env(:elixir_dropbox, :upload_url), "files/upload_session/start", file, headers)
 end

 @doc """
 Append more data to an upload session.

 ## Example

   ElixirDropbox.Files.UploadSession.append(client, "AAAAAAAADipnX-8-d8-V4g", false, "")

 More info at: https://www.dropbox.com/developers/documentation/http/documentation#files-upload_session-append_v2
 """
 def append(client, session_id, close, file, offset \\ 0) do
   cursor = %{"session_id" => session_id, "offset" => offset}
   dropbox_headers = %{
     :close => close,
     :cursor => cursor
   }
   headers = %{ "Dropbox-API-Arg" => Poison.encode!(dropbox_headers), "Content-Type" => "application/octet-stream" }
   upload_request(client, Application.get_env(:elixir_dropbox, :upload_url), "files/upload_session/append_v2", file, headers)
 end

 @doc """
 Finish an upload session and save the uploaded data to the given file path.

 ## Example

   ElixirDropbox.Files.UploadSession.finish(client, "AAAAAAAADipnX-8-d8-V4g", "", "")

 More info at: https://www.dropbox.com/developers/documentation/http/documentation#files-upload_session-finish
 """
 def finish(client, session_id, path, file, offset \\ 0, mode \\ "add", autorename \\ true, mute \\ false) do
   cursor = %{"session_id" => session_id, "offset" => offset}
   commit = %{"path" => path, "mode" => mode, "autorename" => autorename, "mute" => mute}
   dropbox_headers = %{
     :cursor => cursor,
     :commit => commit
   }
   headers = %{ "Dropbox-API-Arg" => Poison.encode!(dropbox_headers), "Content-Type" => "application/octet-stream" }
   upload_request(client, Application.get_env(:elixir_dropbox, :upload_url), "files/upload_session/finish", file, headers)
 end

 @doc """
 This route helps you commit many files at once into a user's Dropbox.

 ## Example
   entry = %{ "cursor" => %{ "session_id" => "AAAAAAAADipnX-8-d8-V4g", "offset" => 0}, "commit" => %{ "path" => "/Homework/math/Matrices.txt" }}
   entries = [entry]
   ElixirDropbox.Files.UploadSession.finish_batch client, entries

 More info at: https://www.dropbox.com/developers/documentation/http/documentation#files-upload_session-finish
 """
 def finish_batch(client, entries) do
   body = %{"entries" => entries}
   result = to_string(Poison.Encoder.encode(body, []))
   post(client, "/files/upload_session/finish_batch", result)
 end

 @doc """
 Returns the status of an asynchronous job for
 upload_session/finish_batch.
 If success, it returns list of result for each entry.

 ## Example

   ElixirDropbox.Files.UploadSession.finish_batch_check(client, "")

 More info at: https://www.dropbox.com/developers/documentation/http/documentation#files-upload_session-finish_batch-check
 """
 def finish_batch_check(client, async_job_id) do
   body = %{"async_job_id" => async_job_id}
   result = to_string(Poison.Encoder.encode(body, []))
   post(client, "/files/upload_session/finish_batch/check", result)
 end
end
