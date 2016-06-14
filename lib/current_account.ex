defmodule ElixirDropbox.CurrentAccount do
	import ElixirDropbox
	alias ElixirDropbox.Client

	def info do
		ElixirDropbox.post "/users/get_current_account"
	end
end