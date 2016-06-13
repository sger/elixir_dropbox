defmodule ElixirDropbox.Client do
	def start do
		HTTPoison.start
	end

	def test_get do
		HTTPoison.get! "http://httparrot.herokuapp.com/get"
	end
end