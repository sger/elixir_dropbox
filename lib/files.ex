defmodule ElixirDropbox.Files do

  def create_folder(client) do
    body = %{"path" => "/test"}
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

end
