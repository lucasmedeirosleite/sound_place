defmodule SoundPlace.Media do
  import Ecto.Query, warn: false
  alias SoundPlace.Repo

  alias SoundPlace.Media.Genre

  def list_genres do
    Repo.all(Genre)
  end

  def get_genre!(id), do: Repo.get!(Genre, id)

  def create_genre(attrs \\ %{}) do
    %Genre{}
    |> Genre.changeset(attrs)
    |> Repo.insert()
  end

  def update_genre(%Genre{} = genre, attrs) do
    genre
    |> Genre.changeset(attrs)
    |> Repo.update()
  end

  def delete_genre(%Genre{} = genre) do
    Repo.delete(genre)
  end

  def change_genre(%Genre{} = genre) do
    Genre.changeset(genre, %{})
  end
end
