defmodule MockinWeb.Pow.Mailer do
  use Pow.Phoenix.Mailer
  use Bamboo.Mailer, otp_app: :mockin

  import Bamboo.Email
  require Logger

  @impl true
  def cast(%{user: user, subject: subject, text: text, html: html, assigns: _assigns}) do
    new_email(
      to: user.email,
      from: "mockmail@mockin.app",
      subject: subject,
      html_body: html,
      text_body: text
    )
  end

  @impl true
  def process(email) do
    deliver_later(email)
    Logger.debug("E-mail sent: #{inspect email}")
  end
end
