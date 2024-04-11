defmodule UrlShortener.Api.Slug do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "slugs" do
    field :slug, :string
    field :url, :string
    field :visited, :integer

    timestamps()
  end

  @doc false
  def changeset(slug, attrs) do
    slug
    |> cast(attrs, [:url, :slug, :visited])
    |> validate_required([:url, :slug, :visited])
    |> unique_constraint(:url)
    |> unique_constraint(:slug)
  end
end
