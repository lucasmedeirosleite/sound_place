defmodule SoundPlace.MediaTest do
  use SoundPlace.DataCase

  alias SoundPlace.Media

  describe "genres" do
    alias SoundPlace.Media.Genre

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def genre_fixture(attrs \\ %{}) do
      {:ok, genre} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Media.create_genre()

      genre
    end

    test "list_genres/0 returns all genres" do
      genre = genre_fixture()
      assert Media.list_genres() == [genre]
    end

    test "get_genre!/1 returns the genre with given id" do
      genre = genre_fixture()
      assert Media.get_genre!(genre.id) == genre
    end

    test "create_genre/1 with valid data creates a genre" do
      assert {:ok, %Genre{} = genre} = Media.create_genre(@valid_attrs)
      assert genre.name == "some name"
    end

    test "create_genre/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Media.create_genre(@invalid_attrs)
    end

    test "update_genre/2 with valid data updates the genre" do
      genre = genre_fixture()
      assert {:ok, genre} = Media.update_genre(genre, @update_attrs)
      assert %Genre{} = genre
      assert genre.name == "some updated name"
    end

    test "update_genre/2 with invalid data returns error changeset" do
      genre = genre_fixture()
      assert {:error, %Ecto.Changeset{}} = Media.update_genre(genre, @invalid_attrs)
      assert genre == Media.get_genre!(genre.id)
    end

    test "delete_genre/1 deletes the genre" do
      genre = genre_fixture()
      assert {:ok, %Genre{}} = Media.delete_genre(genre)
      assert_raise Ecto.NoResultsError, fn -> Media.get_genre!(genre.id) end
    end

    test "change_genre/1 returns a genre changeset" do
      genre = genre_fixture()
      assert %Ecto.Changeset{} = Media.change_genre(genre)
    end
  end

  describe "labels" do
    alias SoundPlace.Media.Label

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def label_fixture(attrs \\ %{}) do
      {:ok, label} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Media.create_label()

      label
    end

    test "list_labels/0 returns all labels" do
      label = label_fixture()
      assert Media.list_labels() == [label]
    end

    test "get_label!/1 returns the label with given id" do
      label = label_fixture()
      assert Media.get_label!(label.id) == label
    end

    test "create_label/1 with valid data creates a label" do
      assert {:ok, %Label{} = label} = Media.create_label(@valid_attrs)
      assert label.name == "some name"
    end

    test "create_label/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Media.create_label(@invalid_attrs)
    end

    test "update_label/2 with valid data updates the label" do
      label = label_fixture()
      assert {:ok, label} = Media.update_label(label, @update_attrs)
      assert %Label{} = label
      assert label.name == "some updated name"
    end

    test "update_label/2 with invalid data returns error changeset" do
      label = label_fixture()
      assert {:error, %Ecto.Changeset{}} = Media.update_label(label, @invalid_attrs)
      assert label == Media.get_label!(label.id)
    end

    test "delete_label/1 deletes the label" do
      label = label_fixture()
      assert {:ok, %Label{}} = Media.delete_label(label)
      assert_raise Ecto.NoResultsError, fn -> Media.get_label!(label.id) end
    end

    test "change_label/1 returns a label changeset" do
      label = label_fixture()
      assert %Ecto.Changeset{} = Media.change_label(label)
    end
  end

  describe "album_types" do
    alias SoundPlace.Media.AlbumType

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def album_type_fixture(attrs \\ %{}) do
      {:ok, album_type} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Media.create_album_type()

      album_type
    end

    test "list_album_types/0 returns all album_types" do
      album_type = album_type_fixture()
      assert Media.list_album_types() == [album_type]
    end

    test "get_album_type!/1 returns the album_type with given id" do
      album_type = album_type_fixture()
      assert Media.get_album_type!(album_type.id) == album_type
    end

    test "create_album_type/1 with valid data creates a album_type" do
      assert {:ok, %AlbumType{} = album_type} = Media.create_album_type(@valid_attrs)
      assert album_type.name == "some name"
    end

    test "create_album_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Media.create_album_type(@invalid_attrs)
    end

    test "update_album_type/2 with valid data updates the album_type" do
      album_type = album_type_fixture()
      assert {:ok, album_type} = Media.update_album_type(album_type, @update_attrs)
      assert %AlbumType{} = album_type
      assert album_type.name == "some updated name"
    end

    test "update_album_type/2 with invalid data returns error changeset" do
      album_type = album_type_fixture()
      assert {:error, %Ecto.Changeset{}} = Media.update_album_type(album_type, @invalid_attrs)
      assert album_type == Media.get_album_type!(album_type.id)
    end

    test "delete_album_type/1 deletes the album_type" do
      album_type = album_type_fixture()
      assert {:ok, %AlbumType{}} = Media.delete_album_type(album_type)
      assert_raise Ecto.NoResultsError, fn -> Media.get_album_type!(album_type.id) end
    end

    test "change_album_type/1 returns a album_type changeset" do
      album_type = album_type_fixture()
      assert %Ecto.Changeset{} = Media.change_album_type(album_type)
    end
  end

  describe "artists" do
    alias SoundPlace.Media.Artist

    @valid_attrs %{facebook: "some facebook", image: "some image", instagram: "some instagram", name: "some name", spotify_id: "some spotify_id", twitter: "some twitter", website: "some website"}
    @update_attrs %{facebook: "some updated facebook", image: "some updated image", instagram: "some updated instagram", name: "some updated name", spotify_id: "some updated spotify_id", twitter: "some updated twitter", website: "some updated website"}
    @invalid_attrs %{facebook: nil, image: nil, instagram: nil, name: nil, spotify_id: nil, twitter: nil, website: nil}

    def artist_fixture(attrs \\ %{}) do
      {:ok, artist} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Media.create_artist()

      artist
    end

    test "list_artists/0 returns all artists" do
      artist = artist_fixture()
      assert Media.list_artists() == [artist]
    end

    test "get_artist!/1 returns the artist with given id" do
      artist = artist_fixture()
      assert Media.get_artist!(artist.id) == artist
    end

    test "create_artist/1 with valid data creates a artist" do
      assert {:ok, %Artist{} = artist} = Media.create_artist(@valid_attrs)
      assert artist.facebook == "some facebook"
      assert artist.image == "some image"
      assert artist.instagram == "some instagram"
      assert artist.name == "some name"
      assert artist.spotify_id == "some spotify_id"
      assert artist.twitter == "some twitter"
      assert artist.website == "some website"
    end

    test "create_artist/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Media.create_artist(@invalid_attrs)
    end

    test "update_artist/2 with valid data updates the artist" do
      artist = artist_fixture()
      assert {:ok, artist} = Media.update_artist(artist, @update_attrs)
      assert %Artist{} = artist
      assert artist.facebook == "some updated facebook"
      assert artist.image == "some updated image"
      assert artist.instagram == "some updated instagram"
      assert artist.name == "some updated name"
      assert artist.spotify_id == "some updated spotify_id"
      assert artist.twitter == "some updated twitter"
      assert artist.website == "some updated website"
    end

    test "update_artist/2 with invalid data returns error changeset" do
      artist = artist_fixture()
      assert {:error, %Ecto.Changeset{}} = Media.update_artist(artist, @invalid_attrs)
      assert artist == Media.get_artist!(artist.id)
    end

    test "delete_artist/1 deletes the artist" do
      artist = artist_fixture()
      assert {:ok, %Artist{}} = Media.delete_artist(artist)
      assert_raise Ecto.NoResultsError, fn -> Media.get_artist!(artist.id) end
    end

    test "change_artist/1 returns a artist changeset" do
      artist = artist_fixture()
      assert %Ecto.Changeset{} = Media.change_artist(artist)
    end
  end
end
