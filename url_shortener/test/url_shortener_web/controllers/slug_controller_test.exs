defmodule UrlShortenerWeb.SlugControllerTest do
  use UrlShortenerWeb.ConnCase

  alias UrlShortener.Api
  alias UrlShortener.Api.Slug

  @create_attrs %{
    url: "https://elixir-lang.org/",
  }

  @invalid_attrs %{
    url: "some invalid url"
  }

  def fixture(:slug) do
    {:ok, slug} = Api.create_slug(@create_attrs)
    slug
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all slugs", %{conn: conn} do
      conn = post(conn, Routes.slug_path(conn, :create), slug: @create_attrs)

      conn = get(conn, Routes.slug_path(conn, :index))

      assert length(json_response(conn, 200)["data"]) == 1
    end
  end

  describe "create slug" do
    test "renders slug when url is valid", %{conn: conn} do
      conn = post(conn, Routes.slug_path(conn, :create), slug: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      entity = json_response(conn, 201)["data"]

      assert entity["id"] == id
      assert entity["url"] == "https://elixir-lang.org/"
      assert entity["visited"] == 0
    end

    test "renders errors when url format is invalid", %{conn: conn} do
      conn = post(conn, Routes.slug_path(conn, :create), slug: @invalid_attrs)
      assert json_response(conn, 400)["errors"] != %{}
    end

    test "renders errors when url protocol is invalid", %{conn: conn} do
      conn = post(conn, Routes.slug_path(conn, :create), slug: %{url: "http://valid-url-format-but-invalid-protocol.org/"})
      assert json_response(conn, 400)["errors"] != %{}
    end

    test "slug property is generated for slug when url is valid", %{conn: conn} do
      conn = post(conn, Routes.slug_path(conn, :create), slug: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      entity = json_response(conn, 201)["data"]

      assert String.trim(entity["slug"]) !== ""
    end

    test "existing slug is returned if url already exists", %{conn: conn} do
      conn = post(conn, Routes.slug_path(conn, :create), slug: @create_attrs)
      entity = json_response(conn, 201)["data"]

      conn = post(conn, Routes.slug_path(conn, :create), slug: @create_attrs)
      existingEntity = json_response(conn, 201)["data"]

      assert entity["id"] == existingEntity["id"]
    end
  end

  defp create_slug(_) do
    slug = fixture(:slug)
    %{slug: slug}
  end
end
