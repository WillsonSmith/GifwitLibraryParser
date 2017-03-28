defmodule GifwitLibraryParser do

  def parse(file_path) do
    File.read!(file_path)
    |> Poison.decode!
    |> Map.get("images")
    |> Enum.map(fn(item) -> {convert_keywords_to_names(Map.get(item, "keywords")), Map.get(item, "url")} end)
  end

  def download(list, download_path) do
    list
    |> Enum.map(&Task.async(fn -> get_file(&1, download_path) end))
    |> Enum.map(&Task.await(&1, 10000))
  end

  def parse_and_download(file_path, download_path \\ "downloads.nosync") do
    create_missing_dir(download_path)
    download(parse(file_path), download_path)
  end

  defp get_file(file, download_path) do
    case HTTPotion.get(elem(file, 1)) do
      %HTTPotion.Response{ body: body, status_code: 200} ->
        File.write!("#{download_path}/#{elem(file, 0)}", body)
      _ ->
        {:err, "not found"}
    end
  end

  defp convert_keywords_to_names(keywords) do
    transformed = String.split(keywords, " ", trim: true)
    |> Enum.join("-")
    "#{transformed}.gif"
  end

  defp create_missing_dir(path) do
    cond do
      !File.exists?(path) ->
        File.mkdir(path)
      true ->
        nil
    end
  end
end
