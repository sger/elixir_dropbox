defmodule ElixirDropbox.Client do
  defstruct client_id: nil,
            access_token: nil
  def new(access_token) do
    %ElixirDropbox.Client{ access_token: access_token }
  end
end
