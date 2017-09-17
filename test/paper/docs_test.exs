defmodule ElixirDropbox.Paper.DocsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ElixirDropbox

  @root_dir File.cwd!
  @paper_dir Path.join(~w(#{@root_dir} test paper test.txt))
  @client ElixirDropbox.Client.new(System.get_env "DROPBOX_ACCESS_TOKEN")

  setup_all do
    HTTPoison.start
  end

  test "create doc" do
    use_cassette "/paper/docs/create" do
  	   doc = ElixirDropbox.Paper.Docs.docs_create @client, "plain_text", "e.iX7ZavGxujPFwhjOZcQrb4aUJ24KyM01bwdIPXS1q3HclCKXx6", @paper_dir
  	    assert doc["doc_id"] != nil
    end
  end
end
