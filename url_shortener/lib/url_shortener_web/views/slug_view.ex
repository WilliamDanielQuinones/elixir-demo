defmodule UrlShortenerWeb.SlugView do
  use UrlShortenerWeb, :view
  alias UrlShortenerWeb.SlugView

  def render("index.json", %{slugs: slugs}) do
    %{data: render_many(slugs, SlugView, "slug.json")}
  end

  def render("show.json", %{slug: slug}) do
    %{data: render_one(slug, SlugView, "slug.json")}
  end

  def render("slug.json", %{slug: slug}) do
    %{id: slug.id,
      url: slug.url,
      slug: slug.slug,
      visited: slug.visited}
  end
end
