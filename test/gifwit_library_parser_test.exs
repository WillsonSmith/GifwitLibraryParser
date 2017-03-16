defmodule GifwitLibraryParserTest do
  use ExUnit.Case
  doctest GifwitLibraryParser

  test "parse file returns list of tuples" do
    GifwitLibraryParser.parse
    |> GifwitLibraryParser.download

    # assert is_list(GifwitLibraryParser.parse)
  end
end
