defmodule GifwitLibraryParser do

  def parse do
    File.read!("giftwitlibrary.gifwit")
    |> Poison.decode!
    |> Map.get("images")
    |> Enum.map(fn(item) -> {convert_keywords_to_names(Map.get(item, "keywords")), Map.get(item, "url")}end)
  end

  def getFile(file) do
    case HTTPotion.get(elem(file, 1)) do
      %HTTPotion.Response{ body: body, status_code: 200} ->
        File.write!("dls/#{elem(file, 0)}", body)
      _ ->
        {:err, "not found"}
    end
  end

  def download(list) do
    Enum.each(list, fn(file) -> 
      spawn(fn -> getFile(file) end)
    end)
  end

  defp convert_keywords_to_names(keywords) do
    transformed = String.split(keywords, " ", trim: true)
    |> Enum.join("-")
    "#{transformed}.gif"
  end
end
