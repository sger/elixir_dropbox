defmodule ElixirDropbox.Client do
  defstruct access_token: nil

  @type access_token :: %{access_token: binary}
  @type t :: %__MODULE__{access_token: access_token}

  @spec new() :: t
  def new(), do: %__MODULE__{}
  
  @spec new(access_token) :: t
  def new(access_token) do
    %__MODULE__{access_token: access_token}
  end
end
