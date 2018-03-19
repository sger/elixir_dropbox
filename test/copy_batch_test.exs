defmodule CopyBatchTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ElixirDropbox

  @client ElixirDropbox.Client.new(System.get_env("DROPBOX_ACCESS_TOKEN"))

  setup_all do
    HTTPoison.start()
  end

  test "get copy batch" do
    use_cassette "copy_batch" do
      copy_batch = ElixirDropbox.Files.CopyBatch.copy_batch(@client, "/Temp", "/Tmp2")
      assert copy_batch["async_job_id"] != nil
    end
  end

  test "check copy batch" do
    use_cassette "copy_batch_check" do
      copy_batch_check =
        ElixirDropbox.Files.CopyBatch.check(
          @client,
          "dbjid:AADfHTK-rZomc8C-kSccfEthUD9Oa4pCikHLzLbskC-EWNwrDaNSzQOdozKzoOPPJPokd9nAI6qFnPlYvtIIca-6"
        )

      assert copy_batch_check[".tag"] != nil
    end
  end
end
