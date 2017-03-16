# GifwitLibraryParser

A small elixir program to parse your [gifwit](http://gifwit.com) library and download all the gifs. Each gif will be named as all of its tags joined with `-` betwene them.

## Example:

>"cool burger man doing stunts"

would become

> cool-burger-man-doing-stunts.gif


## Some issues

* Currently you _must_ run this will `iex -S mix`. The code just spawns a bunch of processes to download the images, but does not keep the app alive while downloading, so if you just try to run the script without an ongoing process, it will not download.
* It spawns a bunch of processes with no batching or any real performance though, this may cause your computer to lock up
* really isn't tested
* it's a first draft
* no options, hard coded to file in directory


<!--**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `gifwit_library_parser` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:gifwit_library_parser, "~> 0.1.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/gifwit_library_parser](https://hexdocs.pm/gifwit_library_parser).
-->
