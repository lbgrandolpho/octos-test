defmodule OctosTestWeb.Schema.Types do
  @moduledoc """
  The Types module defines the GraphQL types used in the schema.

  ## Objects

    * `:user` - Represents a user in the system.
    * `:camera` - Represents a camera device associated with a user.

  ## Fields

  ### User

    * `:id` - The unique identifier of the user.
    * `:name` - The name of the user.
    * `:email` - The email address of the user.
    * `:status` - The status of the user (e.g., "active" or "inactive").
    * `:deactivated_at` - The timestamp when the user was deactivated, if applicable.
    * `:cameras` - The list of cameras associated with the user.

  ### Camera

    * `:id` - The unique identifier of the camera.
    * `:brand` - The brand of the camera.
    * `:status` - The status of the camera (e.g., "active" or "inactive").
  """

  use Absinthe.Schema.Notation

  object :user do
    field :id, :id
    field :name, :string
    field :email, :string
    field :status, :string
    field :deactivated_at, :datetime
    field :cameras, list_of(:camera)
  end

  object :camera do
    field :id, :id
    field :brand, :string
    field :status, :string
  end
end
