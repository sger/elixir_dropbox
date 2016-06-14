defmodule ElixirDropbox.Users do
	import ElixirDropbox
	alias ElixirDropbox.Client

	def current_account do
		 ElixirDropbox.post "/users/get_current_account"
    end

    def current_account_to_struct do 
    	to_struct(%ElixirDropbox.Account{}, ElixirDropbox.post "/users/get_current_account")
    end

    def to_struct(kind, attrs) do
      struct = struct(kind)
      Enum.reduce Map.to_list(struct), struct, fn {k, _}, acc ->
        case Map.fetch(attrs, Atom.to_string(k)) do
          {:ok, v} -> %{acc | k => v}
          :error -> acc
        end
      end
    end
end


