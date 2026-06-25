{-# LANGUAGE OverloadedStrings #-}

module Kobonotes.Generation
    ( renderMarkdown
    , writeMarkdown
    ) where

import           Data.Text as T
import qualified Data.Text.IO as TIO
import           Data.Time.Clock (UTCTime)
import           Data.Time.Format

import Kobonotes.Types


renderMarkdown :: UTCTime -> [Book] -> Text
renderMarkdown time books =
    let timeStr = pack $ formatTime defaultTimeLocale "%B %Y" time
    in  header timeStr <> T.concat (bookEntry <$> books)

writeMarkdown :: FilePath -> UTCTime -> [Book] -> IO ()
writeMarkdown fp time books = TIO.writeFile fp (renderMarkdown time books)

bookEntry :: Book -> Text
bookEntry (Book title author highlights)
    =  "\n\n\n"
    <> "# "  <> title  <> "\n"
    <> "## " <> author <> "\n\n"
    <> T.concat (highlightEntry <$> highlights)
    <> "-------"

highlightEntry :: Highlight -> Text
highlightEntry (Highlight highl note date)
    =  "\n"
    <> (stripEnd . T.unlines) (("> " <>) . stripStart <$> T.lines highl)
    <> "   *" <> date <> "*" <> "\n"
    <> maybe "" ("\n| " <>) note''
    <> "\n"
    where note' = strip <$> note
          note'' = case note' of
                        Just    "" -> Nothing
                        Just    n  -> Just n
                        Nothing    -> Nothing

header :: Text -> Text
header time = "---\n"
       <> "title: Kobo highlights & notes\n"
       <> "author: kobonotes.sillybytse.net\n"
       <> "date: kobonotes.sillybytse.net\n"
       <> "...\n"
       <> "\n"
