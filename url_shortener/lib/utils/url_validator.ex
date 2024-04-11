defmodule UrlShortener.Utils.UrlValidator do
  def valid_url(url) do
    validProtocol = String.starts_with? url, "https://"
    if validProtocol == true do
      case URI.parse(url) do
        %URI{scheme: nil} -> {:error, "No scheme"}
        %URI{host: nil} -> {:error, "No host"}
        _ -> {:ok, url}
      end
    else
      {:error, "Invalid URL"}
    end
  end
end
