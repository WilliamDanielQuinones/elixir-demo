defmodule UrlShortener.Utils.StringGenerator do
  def generate_string() do
    generated = :crypto.strong_rand_bytes(8)
                |> Base.url_encode64()
                |> String.replace(~r/[-_\=]/, "")
    String.slice(generated, 0..8)
  end
end
