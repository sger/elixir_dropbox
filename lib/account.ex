defmodule ElixirDropbox.Account do
  @moduledoc """
  """
  defstruct account_id: nil,
            account_type: nil,
            country: nil,
            disabled: nil,
            email: nil,
            email_verified: nil,
            is_paired: nil,
            locale: nil,
            referral_link: nil,
            name: ElixirDropbox.Name
end
