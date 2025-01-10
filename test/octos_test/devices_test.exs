defmodule OctosTest.DevicesTest do
  use OctosTest.DataCase

  alias OctosTest.Devices

  describe "cameras" do
    alias OctosTest.Devices.Camera

    import OctosTest.DevicesFixtures

    @invalid_attrs %{status: nil, brand: nil}

    test "list_cameras/0 returns all cameras" do
      camera = camera_fixture()
      assert Devices.list_cameras() == [camera]
    end

    test "get_camera!/1 returns the camera with given id" do
      camera = camera_fixture()
      assert Devices.get_camera!(camera.id) == camera
    end

    test "create_camera/1 with valid data creates a camera" do
      valid_attrs = %{status: "some status", brand: "some brand"}

      assert {:ok, %Camera{} = camera} = Devices.create_camera(valid_attrs)
      assert camera.status == "some status"
      assert camera.brand == "some brand"
    end

    test "create_camera/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Devices.create_camera(@invalid_attrs)
    end

    test "update_camera/2 with valid data updates the camera" do
      camera = camera_fixture()
      update_attrs = %{status: "some updated status", brand: "some updated brand"}

      assert {:ok, %Camera{} = camera} = Devices.update_camera(camera, update_attrs)
      assert camera.status == "some updated status"
      assert camera.brand == "some updated brand"
    end

    test "update_camera/2 with invalid data returns error changeset" do
      camera = camera_fixture()
      assert {:error, %Ecto.Changeset{}} = Devices.update_camera(camera, @invalid_attrs)
      assert camera == Devices.get_camera!(camera.id)
    end

    test "delete_camera/1 deletes the camera" do
      camera = camera_fixture()
      assert {:ok, %Camera{}} = Devices.delete_camera(camera)
      assert_raise Ecto.NoResultsError, fn -> Devices.get_camera!(camera.id) end
    end

    test "change_camera/1 returns a camera changeset" do
      camera = camera_fixture()
      assert %Ecto.Changeset{} = Devices.change_camera(camera)
    end
  end
end
