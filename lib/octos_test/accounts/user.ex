defmodule OctosTest.Accounts.User do
  @moduledoc """
  The User schema represents a user in the system.

  ## Fields

    * `:name` - The name of the user.
    * `:email` - The email address of the user.
    * `:status` - The status of the user (e.g., "active" or "inactive").
    * `:deactivated_at` - The timestamp when the user was deactivated, if applicable.

  ## Associations

    * `has_many :cameras` - The cameras associated with the user.

  ## Functions

    * `changeset/2` - Creates a changeset for a user based on the given attributes.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @required_fields ~w(name status email)a

  schema "users" do
    field :name, :string
    field :email, :string
    field :status, :string
    field :deactivated_at, :utc_datetime

    has_many :cameras, OctosTest.Devices.Camera

    timestamps(type: :utc_datetime)
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
