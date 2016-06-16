defmodule ElixirDropbox.Client do
  defstruct client_id: nil,
            token: nil
  def init(token) do
    %ElixirDropbox.Client{ token: token }
  end
end
