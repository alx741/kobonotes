module Main where

import Data.Time.Clock (getCurrentTime)
import System.Environment

import Kobonotes.Extraction
import Kobonotes.Generation

main :: IO ()
main = do
    (dbFile:outFile:_) <- getArgs
    books <- extractBooks dbFile
    now <- getCurrentTime
    writeMarkdown outFile now books
    putStrLn $ "Extracted highlights & notes for " <> show (length books) <> " books"
