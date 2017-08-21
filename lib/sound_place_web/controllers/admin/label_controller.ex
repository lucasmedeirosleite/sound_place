defmodule SoundPlaceWeb.Admin.LabelController do
  use SoundPlaceWeb, :controller

  alias SoundPlace.Media
  alias SoundPlace.Media.Label

  def index(conn, _params) do
    labels = Media.list_labels()
    render(conn, :index, labels: labels)
  end

  def new(conn, _params) do
    changeset = Media.change_label(%Label{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"label" => label_params}) do
    with {:ok, label} <- Media.create_label(label_params) do
      conn
      |> put_flash(:info, "#{label.name} created")
      |> redirect(to: admin_label_path(conn, :index))
    else {:error, %Ecto.Changeset{} = changeset} ->
      render(conn, :new, changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    label = Media.get_label!(id)
    changeset = Media.change_label(label)
    render(conn, "edit.html", label: label, changeset: changeset)
  end

  def update(conn, %{"id" => id, "label" => label_params}) do
    label = Media.get_label!(id)

    with {:ok, label} <- Media.update_label(label, label_params) do
      conn
      |> put_flash(:info, "#{label.name} updated")
      |> redirect(to: admin_label_path(conn, :index))
    else {:error,  %Ecto.Changeset{} = changeset} ->
      render(conn, "edit.html", label: label, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    label = Media.get_label!(id)
    {:ok, _label} = Media.delete_label(label)

    conn
    |> put_flash(:info, "Label deleted successfully.")
    |> redirect(to: admin_label_path(conn, :index))
  end
end
