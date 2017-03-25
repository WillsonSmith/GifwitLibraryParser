defmodule GifwitLibraryParser do

  def parse(file_path) do
    File.read!(file_path)
    |> Poison.decode!
    |> Map.get("images")
    |> Enum.map(fn(item) -> {convert_keywords_to_names(Map.get(item, "keywords")), Map.get(item, "url")}end)
  end

  def download(list) do
    per_spawn = round(Float.ceil(length(list)/20))
    # create 20 processes to download with
    Enum.chunk(list, per_spawn, per_spawn, [])
    |> Enum.each(fn(files) ->
      spawn(fn -> getFiles(files) end)
    end)
  end

  defp getFiles(files) do
    Enum.each(files, fn(file) ->
      case HTTPotion.get(elem(file, 1)) do
        %HTTPotion.Response{ body: body, status_code: 200} ->
          File.write!("dls/#{elem(file, 0)}", body)
        _ ->
          {:err, "not found"}
      end
    end)
  end

  defp convert_keywords_to_names(keywords) do
    transformed = String.split(keywords, " ", trim: true)
    |> Enum.join("-")
    "#{transformed}.gif"
  end
end
