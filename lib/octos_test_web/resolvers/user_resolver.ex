defmodule OctosTestWeb.Resolvers.UserResolver do
  @moduledoc """
  The UserResolver module is responsible for handling GraphQL queries related to users.

  ## Functions

    * `list_users_with_cameras/3` - Lists users with their respective cameras, filtering out cameras for inactive users.
  """

  alias OctosTest.Accounts

  def list_users_with_cameras(_parent, args, _resolution) do
    users =
      Accounts.list_users_with_cameras(args)
      |> Enum.map(fn user ->
        if user.status == "inactive", do: Map.drop(user, [:cameras]), else: user
      end)

    {:ok, users}
  end
end
