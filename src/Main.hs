{-# LANGUAGE OverloadedStrings #-}

module Main where

import Control.Monad (forM_)

import System.Environment

import Types
import Extraction
import Generation

import Data.Default

import Text.Pandoc

someBook = Book "titulo" "autor" []

main :: IO ()
main = do
    pandocEither <- runIO $ readBook someBook

    case pandocEither of
        Left err -> print err
        Right pandoc -> do
            print pandoc

            templateT <- runIO $ getTemplate "template/template.html"
            -- print (templateT :: _)
            let templateEither = fmap (compileTemplate "") templateT
            print templateEither


            -- case templateEither of
            --     Left err -> print err
            --     Right template -> do
            --         print template

            -- html <- runIO $ writeHtml5String (def {writerTemplate = Just }) pandoc
            -- print html

    -- (dbFile:outFile:_) <- getArgs
    -- books <- extractBooks dbFile
    -- writeMarkdown outFile books
    -- putStrLn $ "Extracted highlights & notes for " <> show (length books) <> " books"
