defmodule PetClinic.PetHealthExpertTest do
  use PetClinic.DataCase

  alias PetClinic.PetHealthExpert

  describe "pets" do
    alias PetClinic.PetHealthExpert.Pet

    import PetClinic.PetHealthExpertFixtures

    @invalid_attrs %{age: nil, email: nil, name: nil, sex: nil, specialities: nil}

    test "list_pets/0 returns all pets" do
      pet = pet_fixture()
      assert PetHealthExpert.list_pets() == [pet]
    end

    test "get_pet!/1 returns the pet with given id" do
      pet = pet_fixture()
      assert PetHealthExpert.get_pet!(pet.id) == pet
    end

    test "create_pet/1 with valid data creates a pet" do
      valid_attrs = %{age: 42, email: "some email", name: "some name", sex: "some sex", specialities: "some specialities"}

      assert {:ok, %Pet{} = pet} = PetHealthExpert.create_pet(valid_attrs)
      assert pet.age == 42
      assert pet.email == "some email"
      assert pet.name == "some name"
      assert pet.sex == "some sex"
      assert pet.specialities == "some specialities"
    end

    test "create_pet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PetHealthExpert.create_pet(@invalid_attrs)
    end

    test "update_pet/2 with valid data updates the pet" do
      pet = pet_fixture()
      update_attrs = %{age: 43, email: "some updated email", name: "some updated name", sex: "some updated sex", specialities: "some updated specialities"}

      assert {:ok, %Pet{} = pet} = PetHealthExpert.update_pet(pet, update_attrs)
      assert pet.age == 43
      assert pet.email == "some updated email"
      assert pet.name == "some updated name"
      assert pet.sex == "some updated sex"
      assert pet.specialities == "some updated specialities"
    end

    test "update_pet/2 with invalid data returns error changeset" do
      pet = pet_fixture()
      assert {:error, %Ecto.Changeset{}} = PetHealthExpert.update_pet(pet, @invalid_attrs)
      assert pet == PetHealthExpert.get_pet!(pet.id)
    end

    test "delete_pet/1 deletes the pet" do
      pet = pet_fixture()
      assert {:ok, %Pet{}} = PetHealthExpert.delete_pet(pet)
      assert_raise Ecto.NoResultsError, fn -> PetHealthExpert.get_pet!(pet.id) end
    end

    test "change_pet/1 returns a pet changeset" do
      pet = pet_fixture()
      assert %Ecto.Changeset{} = PetHealthExpert.change_pet(pet)
    end
  end
end
