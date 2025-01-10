defmodule OctosTestWeb.Resolvers.NotificationResolver do
  @moduledoc """
  The NotificationResolver module is responsible for handling GraphQL mutations related to notifications.

  ## Functions

    * `notify_hikvision_users/2` - Sends notification emails to users with Hikvision cameras.
  """

  alias OctosTest.Accounts

  def notify_hikvision_users(_, _) do
    users_with_hikvision_cameras =
      Accounts.list_users_with_hikvision_cameras()

    Enum.each(users_with_hikvision_cameras, fn user ->
      Accounts.send_notification_email(user)
    end)

    {:ok, "Emails sent to users with Hikvision cameras"}
  end
end
