defmodule ElixirDropboxTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ElixirDropbox

  @client ElixirDropbox.Client.new(System.get_env "DROPBOX_ACCESS_TOKEN")

  setup_all do
    HTTPoison.start
  end

  test "get current account" do
    use_cassette "current_account" do
  	   current_account = ElixirDropbox.Users.current_account(@client)
  	    assert current_account["account_id"] != nil
    end
  end

  test "get space usage" do
    use_cassette "get_space_usage" do
      space_usage = ElixirDropbox.Users.get_space_usage(@client)
      assert space_usage["used"] != nil
    end
  end

  test "get metadata" do
    use_cassette "get_metadata" do
  	   folder = ElixirDropbox.Files.create_folder(@client, "/test")
  	   metadata = ElixirDropbox.Files.get_metadata(@client, "/test")
  	   assert metadata[".tag"] == "folder"
  	   assert folder["metadata"]["id"] == metadata["id"]
       deleted_folder = ElixirDropbox.Files.delete_folder(@client, "/test")
       assert deleted_folder["metadata"]["name"] == "test"
    end
  end

  test "create folder" do
    use_cassette "create_folder" do
      folder = ElixirDropbox.Files.create_folder(@client, "/hello_world")
      assert folder["metadata"]["name"] == "hello_world"
      deleted_folder = ElixirDropbox.Files.delete_folder(@client, "/hello_world")
      assert deleted_folder["metadata"]["name"] == "hello_world"
    end
  end

  test "delete folder" do
    use_cassette "delete_folder" do
      folder = ElixirDropbox.Files.create_folder(@client, "/deleted_folder")
      deleted_folder = ElixirDropbox.Files.delete_folder(@client, "/deleted_folder")
      assert folder["metadata"]["name"] == "deleted_folder"
      assert deleted_folder["metadata"]["name"] == "deleted_folder"
    end
  end
end
