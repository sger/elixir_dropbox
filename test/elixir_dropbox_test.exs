defmodule ElixirDropboxTest do
  use ExUnit.Case
  doctest ElixirDropbox

  setup_all do
    access_token = System.get_env "DROPBOX_ACCESS_TOKEN"
    client = ElixirDropbox.Client.new(access_token)
    {:ok, [ client: client ]}
  end

  test "get current account", state do
  	current_account = ElixirDropbox.Users.current_account(state[:client])
  	assert current_account["account_id"] != nil
  end

  test "get space usage", state do
    space_usage = ElixirDropbox.Users.get_space_usage(state[:client])
    assert space_usage["used"] != nil
  end

  test "get metadata", state do
  	folder = ElixirDropbox.Files.create_folder(state[:client], "/test")
  	metadata = ElixirDropbox.Files.get_metadata(state[:client], "/test")
  	assert metadata[".tag"] == "folder"
  	assert folder["id"] == metadata["id"]
  end
end
