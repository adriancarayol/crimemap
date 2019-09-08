defmodule Crimemap.CrimesTest do
  use Crimemap.DataCase

  alias Crimemap.Crimes
  alias Crimemap.Accounts

  describe "crimes" do
    alias Crimemap.Crimes.Crime

    @valid_user_attrs %{email: "email@es.es", password: "some encrypted_password", username: "username"}

    @valid_attrs %{details: "some details", latitude: Decimal.cast("42.000"), longitude: Decimal.cast("42.000"),
                    title: "some title", validated: true, validation_msg: "some validation_msg"}
    @update_attrs %{details: "some updated details", latitude: Decimal.cast("43.000"), longitude: Decimal.cast("43.000"),
                    title: "some updated title", validated: false, validation_msg: "some updated validation_msg"}
    @invalid_attrs %{details: nil, latitude: nil, longitude: nil, title: nil, validated: nil, validation_msg: nil, user: nil}

    defp user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_user_attrs)
        |> Accounts.create_user()

      user
    end

    def crime_fixture(attrs \\ %{}) do
      user = user_fixture()

      attrs_with_user = Map.put(@valid_attrs, :user_id, user.id)

      {:ok, crime} =
        attrs
        |> Enum.into(attrs_with_user)
        |> Crimes.create_crime()

      crime
    end

    test "list_crimes/0 returns all crimes" do
      crime = crime_fixture()
      assert Crimes.list_crimes() == [crime]
    end

    test "get_crime!/1 returns the crime with given id" do
      crime = crime_fixture()
      assert Crimes.get_crime!(crime.id) == crime
    end

    test "create_crime/1 with valid data creates a crime" do
      user = user_fixture()

      attrs_with_user = Map.put(@valid_attrs, :user_id, user.id)

      assert {:ok, %Crime{} = crime} = Crimes.create_crime(attrs_with_user)
      assert crime.details == "some details"
      assert crime.latitude == Decimal.cast("42.000")
      assert crime.longitude == Decimal.cast("42.000")
      assert crime.title == "some title"
      assert crime.validated == true
      assert crime.validation_msg == "some validation_msg"
      assert crime.user_id == user.id
    end

    test "create_crime/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Crimes.create_crime(@invalid_attrs)
    end

    test "update_crime/2 with valid data updates the crime" do
      crime = crime_fixture()
      assert {:ok, %Crime{} = crime} = Crimes.update_crime(crime, @update_attrs)
      assert crime.details == "some updated details"
      assert crime.latitude == Decimal.cast("43.000")
      assert crime.longitude == Decimal.cast("43.000")
      assert crime.title == "some updated title"
      assert crime.validated == false
      assert crime.validation_msg == "some updated validation_msg"
    end

    test "update_crime/2 with invalid data returns error changeset" do
      crime = crime_fixture()
      assert {:error, %Ecto.Changeset{}} = Crimes.update_crime(crime, @invalid_attrs)
      assert crime == Crimes.get_crime!(crime.id)
    end

    test "delete_crime/1 deletes the crime" do
      crime = crime_fixture()
      assert {:ok, %Crime{}} = Crimes.delete_crime(crime)
      assert_raise Ecto.NoResultsError, fn -> Crimes.get_crime!(crime.id) end
    end

    test "change_crime/1 returns a crime changeset" do
      crime = crime_fixture()
      assert %Ecto.Changeset{} = Crimes.change_crime(crime)
    end
  end
end
