defmodule OctosTestWeb.Schema do
  @moduledoc """
  The Schema module defines the GraphQL schema for the OctosTest application.

  ## Queries

    * `:cameras` - Lists users with their respective cameras.

  ## Mutations

    * `:notify_users` - Sends notification emails to users with Hikvision cameras.

  ## Arguments

  ### Cameras Query

    * `:limit` - The maximum number of users to return.
    * `:offset` - The number of users to skip before starting to return results.
    * `:camera_brand` - Filters users by the brand of their cameras.
    * `:order_by_camera_brand` - Orders users by the brand of their cameras.
  """

  use Absinthe.Schema

  import_types(OctosTestWeb.Schema.Types)
  import_types(Absinthe.Type.Custom)

  query do
    @desc "List users with their respective cameras"
    field :cameras, list_of(:user) do
      arg(:limit, :integer)
      arg(:offset, :integer)
      arg(:camera_brand, :string)
      arg(:order_by_camera_brand, :boolean)

      resolve(&OctosTestWeb.Resolvers.UserResolver.list_users_with_cameras/3)
    end
  end

  mutation do
    @desc "Notify users with cameras of the brand Hikvision"
    field :notify_users, :string do
      resolve(&OctosTestWeb.Resolvers.NotificationResolver.notify_hikvision_users/2)
    end
  end
end
