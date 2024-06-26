defmodule UrlShortener.Api do
  @moduledoc """
  The Api context.
  """

  import Ecto.Query, warn: false
  alias UrlShortener.Repo

  alias UrlShortener.Api.Slug

  @doc """
  Returns the list of slugs.

  ## Examples

      iex> list_slugs()
      [%Slug{}, ...]

  """
  def list_slugs do
    Repo.all(Slug)
  end

  @doc """
  Gets a single slug by id.

  Raises `Ecto.NoResultsError` if the Slug does not exist.

  ## Examples

      iex> get_slug!(123)
      %Slug{}

      iex> get_slug!(456)
      ** (Ecto.NoResultsError)

  """
  def get_slug!(id), do: Repo.get!(Slug, id)

  @doc """
  Gets a single slug by slug.

  Raises `Ecto.NoResultsError` if the Slug does not exist.

  ## Examples

      iex> get_slug_by_url!("https://google.com")
      %Slug{}

      iex> get_slug_by_url!("abcde12345_not_a_url")
      ** (Ecto.NoResultsError)

  """
  def get_slug_by_url!(url), do: Repo.one(from(s in Slug, where: s.url == ^url))

  @doc """
  Gets a single slug by slug.

  Raises `Ecto.NoResultsError` if the Slug does not exist.

  ## Examples

      iex> get_slug_by_slug!("https://google.com")
      %Slug{}

      iex> get_slug_by_slug!("abcde12345_not_a_url")
      ** (Ecto.NoResultsError)

  """
  def get_slug_by_slug!(slug), do: Repo.one(from(s in Slug, where: s.slug == ^slug))

  @doc """
  Creates a slug.

  ## Examples

      iex> create_slug(%{field: value})
      {:ok, %Slug{}}

      iex> create_slug(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_slug(attrs \\ %{}) do
    %Slug{}
    |> Slug.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a slug.

  ## Examples

      iex> update_slug(slug, %{field: new_value})
      {:ok, %Slug{}}

      iex> update_slug(slug, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_slug(%Slug{} = slug, attrs) do
    slug
    |> Slug.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a slug.

  ## Examples

      iex> delete_slug(slug)
      {:ok, %Slug{}}

      iex> delete_slug(slug)
      {:error, %Ecto.Changeset{}}

  """
  def delete_slug(%Slug{} = slug) do
    Repo.delete(slug)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking slug changes.

  ## Examples

      iex> change_slug(slug)
      %Ecto.Changeset{data: %Slug{}}

  """
  def change_slug(%Slug{} = slug, attrs \\ %{}) do
    Slug.changeset(slug, attrs)
  end
end
