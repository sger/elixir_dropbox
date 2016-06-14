defimpl Poison.Decoder, for: User do
  def decode(task_list, options) do
    Map.update! task_list, :address, fn address ->
      Poison.Decode.decode(address, Keyword.merge(options, as: [Address]))
    end
  end
end