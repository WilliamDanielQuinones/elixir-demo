defmodule UrlShortenerWeb.SlugControllerTest do
  use UrlShortenerWeb.ConnCase

  alias UrlShortener.Api
  alias UrlShortener.Api.Slug

  @create_attrs %{
    slug: "some slug",
    url: "some url",
    visited: 42
  }
  @update_attrs %{
    slug: "some updated slug",
    url: "some updated url",
    visited: 43
  }
  @invalid_attrs %{slug: nil, url: nil, visited: nil}

  def fixture(:slug) do
    {:ok, slug} = Api.create_slug(@create_attrs)
    slug
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all slugs", %{conn: conn} do
      conn = get(conn, Routes.slug_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create slug" do
    test "renders slug when data is valid", %{conn: conn} do
      conn = post(conn, Routes.slug_path(conn, :create), slug: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.slug_path(conn, id))

      assert %{
               "id" => id,
               "slug" => "some slug",
               "url" => "some url",
               "visited" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.slug_path(conn, :create), slug: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update slug" do
    setup [:create_slug]

    test "renders slug when data is valid", %{conn: conn, slug: %Slug{id: id} = slug} do
      conn = put(conn, Routes.slug_path(conn, :update, slug), slug: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.slug_path(conn id))

      assert %{
               "id" => id,
               "slug" => "some updated slug",
               "url" => "some updated url",
               "visited" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, slug: slug} do
      conn = put(conn, Routes.slug_path(conn, :update, slug), slug: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete slug" do
    setup [:create_slug]

    test "deletes chosen slug", %{conn: conn, slug: slug} do
      conn = delete(conn, Routes.slug_path(conn, :delete, slug))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.slug_path(conn, slug))
      end
    end
  end

  defp create_slug(_) do
    slug = fixture(:slug)
    %{slug: slug}
  end
end
