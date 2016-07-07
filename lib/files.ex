defmodule ElixirDropbox.Files do
 @doc """
  Create folder returns map

  ## Example

    ElixirDropbox.Files.create_folder client, "/Path"

  More info at: https://www.dropbox.com/developers/documentation/http/documentation#files-create_folder
  """  
  @spec create_folder(Client, binary) :: Map
  def create_folder(client, path) do
    body = %{"path" => path}
    result = to_string(Poison.Encoder.encode(body, []))
    ElixirDropbox.post(client, "/files/create_folder", result) 
  end

 @doc """
  Create folder returns Folder struct

  ## Example

    ElixirDropbox.Files.create_folder_to_struct client, "/Path"

  More info at: https://www.dropbox.com/developers/documentation/http/documentation#files-create_folder
  """  
  @spec create_folder_to_struct(Client, binary) :: Map
  def create_folder_to_struct(client, path) do
    response = create_folder(client, path)
    if is_map(response) do
      ElixirDropbox.Utils.to_struct(%ElixirDropbox.Folder{}, response)
    else
      elem(response, 1) 
    end 
  end
  
 @doc """
  Create folder returns map

   ## Example

    ElixirDropbox.Files.delete_folder client, "/Path"

  More info at: https://www.dropbox.com/developers/documentation/http/documentation#files-delete
 """
  def delete_folder(client, path) do 
    body = %{"path" => path}
    result = to_string(Poison.Encoder.encode(body, []))
    ElixirDropbox.post(client, "/files/delete", result) 
  end
 
  def delete_folder_to_struct(client, path) do
    response = delete_folder(client, path)
    if is_map(response) do
      ElixirDropbox.Utils.to_struct(%ElixirDropbox.Folder{}, response)
    else
      elem(response, 1)
    end
  end 
  
  def copy(client, from_path, to_path) do
    body = %{"from_path" => from_path, "to_path" => to_path}
    result = to_string(Poison.Encoder.encode(body, []))
    ElixirDropbox.post(client, "/files/copy", result) 
  end  

  def move(client, from_path, to_path) do
    body = %{"from_path" => from_path, "to_path" => to_path}
    result = to_string(Poison.Encoder.encode(body, []))
    ElixirDropbox.post(client, "/files/move", result) 
  end

  def restore(client, path, rev) do
    body = %{"path" => path, "rev" => rev}
    result = to_string(Poison.Encoder.encode(body, []))
    ElixirDropbox.post(client, "/files/restore", result) 
  end
  
  def list_revisions(client, path, limit \\ 10) do
    body = %{"path" => path, "limit" => limit}
    result = to_string(Poison.Encoder.encode(body, []))
    ElixirDropbox.post(client, "/files/list_revisions", result) 
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

  def download(client, path) do
    dropbox_headers = %{
      :path => path
    }
    headers = %{ "Dropbox-API-Arg" => Poison.encode!(dropbox_headers) }
    ElixirDropbox.download_request(client, "files/download", [], headers)
  end

  def get_thumbnail(client, path, format \\ "jpeg", size \\ "w64h64") do
    dropbox_headers = %{
      :path => path,
      :format => format,
      :size => size
    }
    headers = %{ "Dropbox-API-Arg" => Poison.encode!(dropbox_headers) }
    ElixirDropbox.download_request(client, "files/get_thumbnail", [], headers)
  end
  
  def get_preview(client, path) do
    dropbox_headers = %{
      :path => path
    }
    headers = %{ "Dropbox-API-Arg" => Poison.encode!(dropbox_headers) }
    ElixirDropbox.download_request(client, "files/get_preview", [], headers)
  end

  def get_metadata(client, path, include_media_info \\ false) do
    body = %{"path" => path, "include_media_info" => include_media_info}
    result = to_string(Poison.Encoder.encode(body, []))
    ElixirDropbox.post(client, "/files/get_metadata", result)
   end
end
