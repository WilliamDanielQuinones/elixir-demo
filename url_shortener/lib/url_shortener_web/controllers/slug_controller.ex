defmodule UrlShortenerWeb.SlugController do
  use UrlShortenerWeb, :controller

  alias UrlShortener.Api
  alias UrlShortener.Api.Slug

  action_fallback UrlShortenerWeb.FallbackController

  def index(conn, _params) do
    slugs = Api.list_slugs()
    render(conn, "index.json", slugs: slugs)
  end

  def create(conn, %{"slug" => slug_params}) do
    with {:ok, %Slug{} = slug} <- Api.create_slug(slug_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.slug_path(conn, :show, slug))
      |> render("show.json", slug: slug)
    end
  end

  def show(conn, %{"id" => id}) do
    slug = Api.get_slug!(id)
    render(conn, "show.json", slug: slug)
  end

  def update(conn, %{"id" => id, "slug" => slug_params}) do
    slug = Api.get_slug!(id)

    with {:ok, %Slug{} = slug} <- Api.update_slug(slug, slug_params) do
      render(conn, "show.json", slug: slug)
    end
  end

  def delete(conn, %{"id" => id}) do
    slug = Api.get_slug!(id)

    with {:ok, %Slug{}} <- Api.delete_slug(slug) do
      send_resp(conn, :no_content, "")
    end
  end
end
