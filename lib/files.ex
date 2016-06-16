defmodule ElixirDropbox.Files do

  def create_folder do
    body = %{"path" => "/test"}
    result = to_string(Poison.Encoder.encode(body, []))
    ElixirDropbox.post("/files/create_folder", result) 
  end  

  def upload do
  	{:ok, file} = File.open "README.md"
  	body = %{"path" => "/README.md"}
    result = to_string(Poison.Encoder.encode(body, []))

  	File.close file
  end

end
