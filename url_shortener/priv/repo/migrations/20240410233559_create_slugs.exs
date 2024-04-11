defmodule UrlShortener.Repo.Migrations.CreateSlugs do
  use Ecto.Migration

  def change do
    create table(:slugs, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :url, :string
      add :slug, :string
      add :visited, :integer

      timestamps()
    end

    create unique_index(:slugs, [:url])
    create unique_index(:slugs, [:slug])
  end
end
