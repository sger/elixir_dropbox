defmodule ElixirDropbox.Files do

  def create_folder(client, path) do
    body = %{"path" => path}
    result = to_string(Poison.Encoder.encode(body, []))
    ElixirDropbox.post(client, "/files/create_folder", result) 
  end  

    def upload(client, path, file, mode \\ "add", autorename \\ true, mute \\ false) do
    dropbox_headers = %{
      :path => path,
      :mode => mode,
      :autorename => autorename,
      :mute => mute
    }
    headers = %{ "Dropbox-API-Arg" => Poison.encode!(dropbox_headers), "Content-Type" => "application/octet-stream" }
    ElixirDropbox.upload_request(client, "files/upload", file, headers)
   end

   def get_metadata(client, path, include_media_info \\ false) do
    body = %{"path" => path, "include_media_info" => include_media_info}
    result = to_string(Poison.Encoder.encode(body, []))
    ElixirDropbox.post(client, "/files/get_metadata", result)
   end

end
