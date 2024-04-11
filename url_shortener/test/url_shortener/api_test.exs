defmodule UrlShortener.ApiTest do
  use UrlShortener.DataCase

  alias UrlShortener.Api

  describe "slugs" do
    alias UrlShortener.Api.Slug

    @valid_attrs %{
      url: "https://elixir-lang.org/",
      visited: 0,
      slug: "a1b2c3d4"
    }
    @update_attrs %{
      visited: 3
    }
    @invalid_attrs %{
      visited: "invalid key format",
    }

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

    test "update_slug/2 with duplicate url returns error changeset" do
      slug = slug_fixture()
      Api.create_slug(%{url: "https://yahoo.com/", visited: 0, slug: "e5f6g7h8"})
      assert {:error, %Ecto.Changeset{}} = Api.update_slug(slug, %{url: "https://yahoo.com/"})
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
