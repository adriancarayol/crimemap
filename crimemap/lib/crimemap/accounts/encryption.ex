defmodule Crimemap.Accounts.Encryption do
  @moduledoc """
    This is the Encryption module.
  """
  alias Crimemap.Accounts.User

  @doc """
  Encrypt a password given `password`.
  Returns `hash password`
  ## Examples
      iex > Crimemap.Accounts.Encryption.encrpy_password("yeah")
      "$argon2id$v=19$m=131072,t=8,p=4$Sz1kqN7/B4XxnlPTObG3oA$MVXxbLhMQP3Rbv1K79AkhTsPY2/KdhvPmRG5HjWRucA"
  """
  def encrypt_password(password), do: Argon2.hash_pwd_salt(password)

  @doc """
  Validate a password given `user` and `password`
  Returns `true if password match with the hash, false in other case`
  ## Examples
    iex > Crimemap.Accounts.Encryption.validate_password(%User{encrypted_password: "yeah", "yeah"})
    true
  """
  def validate_password(%User{} = user, password), do: Argon2.verify_pass(password, user.encrypted_password)
end
