defmodule ElixirDropbox.Users do
	import ElixirDropbox
	alias ElixirDropbox.Client

	def get_usage do
		ElixirDropbox.post "/users/get_space_usage"
	end

	def get_account do
		# body = %{ "account_id" => "dbid:AABYkM-pR8ynnNPIVBjMTPRrIyuT4bgtick" }

    # headers = [{"Authorization", "Bearer #{Application.get_env(:elixir_dropbox, :access_token)}"}]
    # headers = [{"Content-Type", "application/json"} | headers]

    # First way
    # HTTPoison.post("https://api.dropboxapi.com/2/users/get_account", "{\"account_id\": \"dbid:AABYkM-pR8ynnNPIVBjMTPRrIyuT4bgtick\"}", headers)

    # second way
    # HTTPoison.request(:post, "https://api.dropboxapi.com/2/users/get_account", "{\"account_id\": \"dbid:AABYkM-pR8ynnNPIVBjMTPRrIyuT4bgtick\"}", headers)

    # third way

    # HTTPoison.post("https://api.dropboxapi.com/2/users/get_space_usage", "null", headers)
    # HTTPoison.post("https://api.dropboxapi.com/2/users/get_current_account", "null", headers)

    # fourth way
    # ElixirDropbox.do_request(:post, "/users/get_space_usage", "null")
    # ElixirDropbox.do_request(:post, "/users/get_current_account", "null")
    # ElixirDropbox.do_request(:post, "/users/get_account", "{\"account_id\": \"dbid:AABYkM-pR8ynnNPIVBjMTPRrIyuT4bgtick\"}")

    # ElixirDropbox.post("/users/get_space_usage", "null")
    # ElixirDropbox.post("/users/get_current_account", "null")

     body = %{"account_id" => "dbid:AABYkM-pR8ynnNPIVBjMTPRrIyuT4bgtick"}
     result = to_string(Poison.Encoder.encode(body, []))
    # IO.puts result

     ElixirDropbox.post("/users/get_account", result)
   
	end



	 def current_account do
		 ElixirDropbox.post("/users/get_current_account", "null")
    end

    def current_account_to_struct do 
    	to_struct(%ElixirDropbox.Account{}, ElixirDropbox.post("/users/get_current_account", "null"))
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


