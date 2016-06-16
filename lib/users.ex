defmodule ElixirDropbox.Users do
  
  @doc """
  Get user account by account_id

  ## Example

    ElixirDropbox.Users dbid:AABYkM-pR8ynnNPIVBjMTPRrIyuT4bgtest, client  

  More info at: https://www.dropbox.com/developers/documentation/http/documentation#users-get_current_account
  """  
  @spec get_account(binary, Client) :: Map
  def get_account(id, client) do
    body = %{"account_id" => id}
    result = to_string(Poison.Encoder.encode(body, []))
    ElixirDropbox.post(client, "/users/get_account", result)
  end

  @spec get_account_to_struct(binary, Client) :: Map
  def get_account_to_struct(id, client) do
    to_struct(%ElixirDropbox.Account{}, get_account(id, client))
  end

  def current_account(client) do
    ElixirDropbox.post(client, "/users/get_current_account", "null")
  end

  def current_account_to_struct(client) do 
    to_struct(%ElixirDropbox.Account{}, current_account(client))
  end

  def get_space_usage(client) do
    ElixirDropbox.post(client, "/users/get_space_usage", "null")
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


