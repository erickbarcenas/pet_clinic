defmodule PetClinic.PetHealthExpertFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PetClinic.PetHealthExpert` context.
  """

  @doc """
  Generate a pet.
  """
  def pet_fixture(attrs \\ %{}) do
    {:ok, pet} =
      attrs
      |> Enum.into(%{
        age: 42,
        email: "some email",
        name: "some name",
        sex: "some sex",
        specialities: "some specialities"
      })
      |> PetClinic.PetHealthExpert.create_pet()

    pet
  end
end
