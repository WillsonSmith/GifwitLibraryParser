defmodule GifwitLibraryParserTest do
  use ExUnit.Case
  doctest GifwitLibraryParser

  test "parse file returns list of tuples" do
    parsed_file = GifwitLibraryParser.parse("test/giftwitlibrary.test.gifwit")
    assert is_list(parsed_file)
    assert is_tuple(List.first(parsed_file))
  end

  test "parse file properly unescapes urls" do
    parsed_file = GifwitLibraryParser.parse("test/giftwitlibrary.test.gifwit")
    assert elem(List.first(parsed_file), 1) == "https://31.media.tumblr.com/b22a1e5b612344ab35c40fe865dac1f7/tumblr_inline_n04sfkB2NP1qbygev.gif"
  end

  test "parse file turns tags into filename" do
    parsed_file = GifwitLibraryParser.parse("test/giftwitlibrary.test.gifwit")
    assert elem(List.first(parsed_file), 0) == "uhh-what-fresh-prince-will.gif"
  end
end
