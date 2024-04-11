defmodule UrlShortenerWeb.SlugController do
  use UrlShortenerWeb, :controller

  alias UrlShortener.Api
  alias UrlShortener.Api.Slug

  action_fallback UrlShortenerWeb.FallbackController

  def index(conn, _params) do
    slugs = Api.list_slugs()
    render(conn, "index.json", slugs: slugs)
  end

  # Validate the URL and create a new slug. If url already exists, return that slug
  def create(conn, %{"slug" => slug_params}) do
    {isValid, _validMessage} = UrlShortener.Utils.UrlValidator.valid_url(slug_params["url"])
    IO.inspect(isValid)
    if isValid == :ok do
      exists = Api.get_slug_by_url!(slug_params["url"])
      if exists == :nil do
        slug = String.downcase(UrlShortener.Utils.StringGenerator.generate_string())
        payload = %{:url => slug_params["url"], visited: 0, slug: slug}
        with {:ok, %Slug{} = slug} <- Api.create_slug(payload) do
          conn
          |> put_status(:created)
          |> render("show.json", slug: slug)
        end
      else
        conn
        |> put_status(:created)
        |> render("show.json", slug: exists)
      end
    else
      conn
      |> put_status(400)
      |> render(UrlShortenerWeb.ApiErrors, "400.json", %{message: "Invalid URL: Must have https:// protocol and valid url structure."})
    end
  end

  def show(conn, %{"id" => id}) do
    slug = Api.get_slug!(id)
    render(conn, "show.json", slug: slug)
  end

  def show_by_slug(conn, %{"slug" => slug}) do
    slug = Api.get_slug_by_slug!(slug)
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
