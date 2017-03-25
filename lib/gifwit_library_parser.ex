defmodule GifwitLibraryParser do

  def parse(file_path) do
    File.read!(file_path)
    |> Poison.decode!
    |> Map.get("images")
    |> Enum.map(fn(item) -> {convert_keywords_to_names(Map.get(item, "keywords")), Map.get(item, "url")}end)
  end

  def download(list) do
    list
    |> Enum.map(&Task.async(fn -> get_file(&1) end))
    |> Enum.map(&Task.await(&1, 10000))
  end

  def parse_and_download(file_path) do
    download(parse(file_path))
  end

  defp get_file(file) do
    case HTTPotion.get(elem(file, 1)) do
      %HTTPotion.Response{ body: body, status_code: 200} ->
        File.write!("downloads.nosync/#{elem(file, 0)}", body)
      _ ->
        {:err, "not found"}
    end
  end

  defp convert_keywords_to_names(keywords) do
    transformed = String.split(keywords, " ", trim: true)
    |> Enum.join("-")
    "#{transformed}.gif"
  end
end
