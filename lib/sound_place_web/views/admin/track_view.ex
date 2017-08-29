defmodule SoundPlaceWeb.Admin.TrackView do
  use SoundPlaceWeb, :view

  def genre_selected?(%Ecto.Association.NotLoaded{}), do: [0]
  def genre_selected?(genres), do: Enum.map(genres, &(&1.id))

  def genres_representation(genres) do
    Enum.map(genres, &({&1.name, &1.id}))
  end
end
