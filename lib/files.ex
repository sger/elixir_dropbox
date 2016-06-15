defmodule ElixirDropbox.Files do

  def create_folder do
    body = %{"path" => "/test"}
    result = to_string(Poison.Encoder.encode(body, []))
    ElixirDropbox.post("/files/create_folder", result) 
  end  

end
