# Kobonotes

Generate a [PDF, HTML, EPUB] file with all the highlights and notes from your
Kobo ereader device.


## Usage

1. Install [the build tools](https://www.haskell.org/ghcup/) and compile:

    $ cabal build


2. Run. First argument `KoboReader.sqlite` file. Second  argument `out.md`:

    $ cabal run -- kobonotes ~/KoboReader.sqlite ./out.md


3. Generate aggregate file:

    $ make kobo.html
    $ make kobo.pdf
    $ make kobo.epub
