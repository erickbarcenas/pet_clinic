defmodule PetClinicWeb.PetController do
  use PetClinicWeb, :controller

  alias PetClinic.PetHealthExpert
  alias PetClinic.PetHealthExpert.Pet

  import Plug.Conn.Status, only: [code: 1]
  use PhoenixSwagger

  swagger_path :index do
    get("/")
    description("List of pets")
    response(code(:ok), "Success")
  end

  def index(conn, _params) do
    pets = PetHealthExpert.list_pets()
    render(conn, "index.html", pets: pets)
  end

  def new(conn, _params) do
    changeset = PetHealthExpert.change_pet(%Pet{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"pet" => pet_params}) do
    case PetHealthExpert.create_pet(pet_params) do
      {:ok, pet} ->
        conn
        |> put_flash(:info, "Pet created successfully.")
        |> redirect(to: Routes.pet_path(conn, :show, pet))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    pet = PetHealthExpert.get_pet!(id)
    render(conn, "show.html", pet: pet)
  end

  def edit(conn, %{"id" => id}) do
    pet = PetHealthExpert.get_pet!(id)
    changeset = PetHealthExpert.change_pet(pet)
    render(conn, "edit.html", pet: pet, changeset: changeset)
  end

  def update(conn, %{"id" => id, "pet" => pet_params}) do
    pet = PetHealthExpert.get_pet!(id)

    case PetHealthExpert.update_pet(pet, pet_params) do
      {:ok, pet} ->
        conn
        |> put_flash(:info, "Pet updated successfully.")
        |> redirect(to: Routes.pet_path(conn, :show, pet))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", pet: pet, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    pet = PetHealthExpert.get_pet!(id)
    {:ok, _pet} = PetHealthExpert.delete_pet(pet)

    conn
    |> put_flash(:info, "Pet deleted successfully.")
    |> redirect(to: Routes.pet_path(conn, :index))
  end
end
