module Main where

import Control.Monad (forM_)

import System.Environment

import Types
import Extraction
import Generation

main :: IO ()
main = do
    (dbFile:outFile:_) <- getArgs
    books <- extractBooks dbFile
    writeMarkdown outFile books
    putStrLn $ "Extracted highlights & notes for " <> show (length books) <> " books"
