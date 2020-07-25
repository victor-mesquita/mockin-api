defmodule MockinWeb.PowResetPassword.MailerView do
  use MockinWeb, :view

  def subject(:reset_password, _assigns), do: "[Mock-in] - Redefina sua senha!"
end
