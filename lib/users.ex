defmodule ElixirDropbox.Users do
  import ElixirDropbox
  alias ElixirDropbox.Client

  def get_usage do
    ElixirDropbox.post "/users/get_space_usage", "null"
  end

  def get_usage_to_struct do
    
  end

  def get_account(id) do
    body = %{"account_id" => id}
    result = to_string(Poison.Encoder.encode(body, []))
    ElixirDropbox.post("/users/get_account", result)
  end

  def get_account_to_struct(id) do
    to_struct(%ElixirDropbox.Account{}, get_account(id))
  end

  def current_account do
    ElixirDropbox.post("/users/get_current_account", "null")
  end

  def current_account_to_struct do 
    to_struct(%ElixirDropbox.Account{}, current_account)
  end

  def get_space_usage do
    ElixirDropbox.post("/users/get_space_usage", "null")
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


