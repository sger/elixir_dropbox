defmodule ElixirDropbox.Name do
	@derive [Poison.Encoder]
	defstruct display_name: nil,
    		  familiar_name: nil,
              given_name: nil,
              surname: nil

      
end
