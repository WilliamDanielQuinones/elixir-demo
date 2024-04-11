defmodule UrlShortenerWeb.FallbackController do
  use UrlShortenerWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    IO.inspect(changeset) ## log error
    conn
    |> put_status(
      if changeset.action in [:insert, :update] do
        400
      else
        404
      end
    )
    |> render(UrlShortenerWeb.ApiErrors,
    if changeset.action in [:insert, :update] do
      "400.json"
    else
      "404.json"
    end,
    %{message:
      if changeset.action in [:insert, :update] do
        "Bad Request"
      else
        "Not Found"
      end
    })
  end
end
