defmodule CopyReferenceTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ElixirDropbox

  @client ElixirDropbox.Client.new(System.get_env("DROPBOX_ACCESS_TOKEN"))

  setup_all do
    HTTPoison.start()
  end

  test "get copy_reference" do
    use_cassette "/files/copy_reference/get" do
      result = ElixirDropbox.Files.CopyReference.get(@client, "/Temp")
      assert result["copy_reference"] != nil
    end
  end

  test "save copy_reference" do
    use_cassette "/files/copy_reference/save" do
      result =
        ElixirDropbox.Files.CopyReference.save(
          @client,
          "AAAAACf83yBxc3JzeWtueHJneHI",
          "/TempCopy"
        )

      assert result["metadata"] != nil
    end
  end
end
