module Main where

import Types
import Extraction

main :: IO ()
main = do
    let db = "KoboReader.sqlite"
    books <- extractBooks db
    print books
