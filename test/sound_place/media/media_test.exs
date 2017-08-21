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
end
