defmodule OctosTest.Emails.UserEmail do
  @moduledoc """
  The UserEmail module is responsible for creating email notifications for users.

  ## Functions

    * `notification_email/1` - Creates a notification email for a user about their Hikvision cameras.
  """

  import Swoosh.Email

  def notification_email(user) do
    new()
    |> to({user.name, user.email})
    |> from({"Octos Team", "support@octos.ai"})
    |> subject("Notification about your Hikvision cameras")
    |> html_body("<h1>Hello, #{user.name}! You have active Hikvision cameras!</h1>")
    |> text_body("Hello, #{user.name}! You have active Hikvision cameras!")
  end
end
