defmodule ElixirDropbox.Client do
	
	@dropbox_url Application.get_env(:elixir_dropbox, :dropbox_url)

	def start do
		HTTPoison.start
	end

	def test_get do
		HTTPoison.get! "http://httparrot.herokuapp.com/get"
	end

	def print_url do
		IO.puts "#{@dropbox_url}"
	end
end