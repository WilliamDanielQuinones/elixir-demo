defmodule UrlShortener.ApiTest do
  use UrlShortener.DataCase

  alias UrlShortener.Api

  describe "slugs" do
    alias UrlShortener.Api.Slug

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def slug_fixture(attrs \\ %{}) do
      {:ok, slug} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Api.create_slug()

      slug
    end

    test "list_slugs/0 returns all slugs" do
      slug = slug_fixture()
      assert Api.list_slugs() == [slug]
    end

    test "get_slug!/1 returns the slug with given id" do
      slug = slug_fixture()
      assert Api.get_slug!(slug.id) == slug
    end

    test "create_slug/1 with valid data creates a slug" do
      assert {:ok, %Slug{} = slug} = Api.create_slug(@valid_attrs)
    end

    test "create_slug/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Api.create_slug(@invalid_attrs)
    end

    test "update_slug/2 with valid data updates the slug" do
      slug = slug_fixture()
      assert {:ok, %Slug{} = slug} = Api.update_slug(slug, @update_attrs)
    end

    test "update_slug/2 with invalid data returns error changeset" do
      slug = slug_fixture()
      assert {:error, %Ecto.Changeset{}} = Api.update_slug(slug, @invalid_attrs)
      assert slug == Api.get_slug!(slug.id)
    end

    test "delete_slug/1 deletes the slug" do
      slug = slug_fixture()
      assert {:ok, %Slug{}} = Api.delete_slug(slug)
      assert_raise Ecto.NoResultsError, fn -> Api.get_slug!(slug.id) end
    end

    test "change_slug/1 returns a slug changeset" do
      slug = slug_fixture()
      assert %Ecto.Changeset{} = Api.change_slug(slug)
    end
  end

  describe "slugs" do
    alias UrlShortener.Api.Slug

    @valid_attrs %{slug: "some slug", url: "some url", visited: 42}
    @update_attrs %{slug: "some updated slug", url: "some updated url", visited: 43}
    @invalid_attrs %{slug: nil, url: nil, visited: nil}

    def slug_fixture(attrs \\ %{}) do
      {:ok, slug} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Api.create_slug()

      slug
    end

    test "list_slugs/0 returns all slugs" do
      slug = slug_fixture()
      assert Api.list_slugs() == [slug]
    end

    test "get_slug!/1 returns the slug with given id" do
      slug = slug_fixture()
      assert Api.get_slug!(slug.id) == slug
    end

    test "create_slug/1 with valid data creates a slug" do
      assert {:ok, %Slug{} = slug} = Api.create_slug(@valid_attrs)
      assert slug.slug == "some slug"
      assert slug.url == "some url"
      assert slug.visited == 42
    end

    test "create_slug/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Api.create_slug(@invalid_attrs)
    end

    test "update_slug/2 with valid data updates the slug" do
      slug = slug_fixture()
      assert {:ok, %Slug{} = slug} = Api.update_slug(slug, @update_attrs)
      assert slug.slug == "some updated slug"
      assert slug.url == "some updated url"
      assert slug.visited == 43
    end

    test "update_slug/2 with invalid data returns error changeset" do
      slug = slug_fixture()
      assert {:error, %Ecto.Changeset{}} = Api.update_slug(slug, @invalid_attrs)
      assert slug == Api.get_slug!(slug.id)
    end

    test "delete_slug/1 deletes the slug" do
      slug = slug_fixture()
      assert {:ok, %Slug{}} = Api.delete_slug(slug)
      assert_raise Ecto.NoResultsError, fn -> Api.get_slug!(slug.id) end
    end

    test "change_slug/1 returns a slug changeset" do
      slug = slug_fixture()
      assert %Ecto.Changeset{} = Api.change_slug(slug)
    end
  end
end
