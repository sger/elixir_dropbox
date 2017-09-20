defmodule ElixirDropbox.Files do
  @moduledoc """
  This module contains endpoints and data types
  for basic file operations.
  """
 import ElixirDropbox
 import ElixirDropbox.Utils

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
    post(client, "/files/create_folder_v2", result)
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
      to_struct(%ElixirDropbox.Folder{}, response)
    else
      elem(response, 1)
    end
  end

 @doc """
 Delete the file or folder at a given path.
 If the path is a folder, all its contents will be deleted too.
 A successful response indicates that the file or folder was deleted.
 The returned metadata will be the corresponding FileMetadata
 or FolderMetadata for the item at time of deletion, and not a DeletedMetadata object.

 ## Example

    ElixirDropbox.Files.delete_folder client, "/Homework/math/Prime_Numbers.txt"

 More info at: https://www.dropbox.com/developers/documentation/http/documentation#files-delete_v2
 """
  def delete_folder(client, path) do
    body = %{"path" => path}
    result = to_string(Poison.Encoder.encode(body, []))
    post(client, "/files/delete_v2", result)
  end

  @doc """
  Delete folder returns Folder struct

  ## Example

    ElixirDropbox.Files.delete_folder_to_struct client, "/Path"

  More info at: https://www.dropbox.com/developers/documentation/http/documentation#files-delete
  """
  def delete_folder_to_struct(client, path) do
    response = delete_folder(client, path)
    if is_map(response) do
      to_struct(%ElixirDropbox.Folder{}, response)
    else
      elem(response, 1)
    end
  end

  @doc """
  Copy a file or folder to a different location in the user's Dropbox.
  If the source path is a folder all its contents will be copied.

  ## Example

    ElixirDropbox.Files.copy(client, "/Temp/first", "/Tmp/second")

  More info at: https://www.dropbox.com/developers/documentation/http/documentation#files-copy_v2
  """
  def copy(client, from_path, to_path) do
    body = %{"from_path" => from_path, "to_path" => to_path}
    result = to_string(Poison.Encoder.encode(body, []))
    post(client, "/files/copy_v2", result)
  end

  @doc """
  Move a file or folder to a different location in the user's Dropbox.
  If the source path is a folder all its contents will be moved.

  ## Example

    ElixirDropbox.Files.move(client, "/Homework/math", "/Homework/algebra")

  More info at: https://www.dropbox.com/developers/documentation/http/documentation#files-move
  """
  def move(client, from_path, to_path) do
    body = %{"from_path" => from_path, "to_path" => to_path}
    result = to_string(Poison.Encoder.encode(body, []))
    post(client, "/files/move", result)
  end

  @doc """
  Restore a file to a specific revision.

  ## Example

    ElixirDropbox.Files.restore(client, "/root/word.docx", "a1c10ce0dd78")

  More info at: https://www.dropbox.com/developers/documentation/http/documentation#files-restore
  """
  def restore(client, path, rev) do
    body = %{"path" => path, "rev" => rev}
    result = to_string(Poison.Encoder.encode(body, []))
    post(client, "/files/restore", result)
  end

  @doc """
  Searches for files and folders.

  ## Example

    ElixirDropbox.Files.search(client, "/root", "word.docx")

  More info at: https://www.dropbox.com/developers/documentation/http/documentation#files-search
  """
  def search(client, path, query, start \\ 0, max_results \\ 100, mode \\ "filename") do
    body = %{"path" => path, "query" => query, "start" => start, "max_results" => max_results, "mode" => mode}
    result = to_string(Poison.Encoder.encode(body, []))
    post(client, "/files/search", result)
  end

  @doc """
  Create a new file with the contents provided in the request.

  ## Example

    ElixirDropbox.Files.upload client, "/mypdf.pdf", "/mypdf.pdf"

  More info at: https://www.dropbox.com/developers/documentation/http/documentation#files-upload
  """
  def upload(client, path, file, mode \\ "add", autorename \\ true, mute \\ false) do
    dropbox_headers = %{
      :path => path,
      :mode => mode,
      :autorename => autorename,
      :mute => mute
    }
    headers = %{ "Dropbox-API-Arg" => Poison.encode!(dropbox_headers), "Content-Type" => "application/octet-stream" }
    upload_request(client, Application.get_env(:elixir_dropbox, :upload_url), "files/upload", file, headers)
  end

  @doc """
  Download a file from a user's Dropbox.

  ## Example

    ElixirDropbox.Files.download client, "/mypdf.pdf"

  More info at: https://www.dropbox.com/developers/documentation/http/documentation#files-download
  """
  def download(client, path) do
    dropbox_headers = %{
      :path => path
    }
    headers = %{ "Dropbox-API-Arg" => Poison.encode!(dropbox_headers) }
    download_request(client, Application.get_env(:elixir_dropbox, :upload_url), "files/download", [], headers)
  end

  @doc """
  Get a thumbnail for an image.

  ## Example

    ElixirDropbox.Files.get_thumbnail client, "/image.jpg"

  More info at: https://www.dropbox.com/developers/documentation/http/documentation#files-get_thumbnail
  """
  def get_thumbnail(client, path, format \\ "jpeg", size \\ "w64h64") do
    dropbox_headers = %{
      :path => path,
      :format => format,
      :size => size
    }
    headers = %{ "Dropbox-API-Arg" => Poison.encode!(dropbox_headers) }
    download_request(client, Application.get_env(:elixir_dropbox, :upload_url), "files/get_thumbnail", [], headers)
  end

  @doc """
  Get thumbnails for a list of images. We allow up to 25 thumbnails in a single batch.

  ## Example
    batch = %{ "path" => "/image.jpg", "format" => "jpeg", "size" => "w64h64"}
    entries = [batch]
    ElixirDropbox.Files.get_thumbnail_batch client, entries

  More info at: https://www.dropbox.com/developers/documentation/http/documentation#files-get_thumbnail_batch
  """
  def get_thumbnail_batch(client, entries) do
    body = %{"entries" => entries}
    result = to_string(Poison.Encoder.encode(body, []))
    post_url(client, Application.get_env(:elixir_dropbox, :upload_url), "/files/get_thumbnail_batch", result)
  end

  @doc """
  Get a preview for a file.

  ## Example

    ElixirDropbox.Files.get_preview client, "/mypdf.pdf"

  More info at: https://www.dropbox.com/developers/documentation/http/documentation#files-get_preview
  """
  def get_preview(client, path) do
    dropbox_headers = %{
      :path => path
    }
    headers = %{ "Dropbox-API-Arg" => Poison.encode!(dropbox_headers) }
    download_request(client, Application.get_env(:elixir_dropbox, :upload_url), "files/get_preview", [], headers)
  end

  @doc """
  Get a temporary link to stream content of a file. This link will expire in four hours and afterwards you will get 410 Gone. Content-Type of the link is determined automatically by the file's mime type.

  ## Example

    ElixirDropbox.Files.get_temporary_link client, "/video.mp4"

  More info at: https://www.dropbox.com/developers/documentation/http/documentation#files-get_preview
  """
  def get_temporary_link(client, path) do
    body = %{"path" => path}
    result = to_string(Poison.Encoder.encode(body, []))
    post(client, "/files/get_temporary_link", result)
  end

  @doc """
  Returns the metadata for a file or folder.

  ## Example

    ElixirDropbox.Files.get_metadata client, "/mypdf.pdf"

  More info at: https://www.dropbox.com/developers/documentation/http/documentation#files-get_metadata
  """
  def get_metadata(client, path, include_media_info \\ false, include_deleted \\ false, include_has_explicit_shared_members \\ false) do
    body = %{"path" => path, "include_media_info" => include_media_info, "include_deleted" => include_deleted, "include_has_explicit_shared_members" => include_has_explicit_shared_members}
    result = to_string(Poison.Encoder.encode(body, []))
    post(client, "/files/get_metadata", result)
   end
end
