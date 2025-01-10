defmodule OctosTest.Devices.Camera do
  @moduledoc """
  The Camera schema represents a camera device in the system.

  ## Fields

    * `:status` - The status of the camera (e.g., "active" or "inactive").
    * `:brand` - The brand of the camera.

  ## Associations

    * `belongs_to :user` - The user to whom the camera belongs.

  ## Functions

    * `changeset/2` - Creates a changeset for a camera based on the given attributes.
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "cameras" do
    field :status, :string
    field :brand, :string

    belongs_to :user, OctosTest.Accounts.User

    timestamps(type: :utc_datetime)
  end

  def changeset(camera, attrs) do
    camera
    |> cast(attrs, [:brand, :status])
    |> validate_required([:brand, :status])
  end
end
