defmodule UrlShortenerWeb.ApiErrors do
  def render("400.json", %{message: message}) do
    %{
      status: 400,
      message: message
    }
  end

  def render("404.json", %{message: message}) do
    %{
      status: 404,
      message: message
    }
  end
end
