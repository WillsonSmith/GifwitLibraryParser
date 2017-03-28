# GifwitLibraryParser

A small elixir program to parse your [gifwit](http://gifwit.com) library and download all the gifs. Each gif will be named as all of its tags joined with `-` betwene them.

## Example:

>"cool burger man doing stunts"

would become

> cool-burger-man-doing-stunts.gif


## Some issues
* testing is minimal, it should have more


## API

### `GifwitLibraryParser.parse/1`
This accepts a file `path` and will return a list of tuples with data from your gifwit library

### `GifwitLibraryParser.download/2`
This takes a file item (tuple from parser), and a downlaod directory. It will download the file to the directory

### `GifwitLibraryParser.parse_and_download/2`
This takes a file `path` and a download directory. It will parse all of the files and downlaod each of them.
