defmodule OctosTest.DevicesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `OctosTest.Devices` context.
  """

  @doc """
  Generate a camera.
  """
  def camera_fixture(attrs \\ %{}) do
    {:ok, camera} =
      attrs
      |> Enum.into(%{
        brand: "some brand",
        status: "some status"
      })
      |> OctosTest.Devices.create_camera()

    camera
  end
end
