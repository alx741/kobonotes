{-# LANGUAGE OverloadedStrings #-}

module Generation
    (writeMarkdown
    ) where

import           Data.Bool    (bool)
import           Data.Maybe   (isJust)
import           Data.Text as T
import qualified Data.Text.IO as TIO
import Data.Time.Format
import Data.Time

import Types


writeMarkdown :: FilePath -> [Book] -> IO ()
writeMarkdown fp books = do

    currentTime <- getCurrentTime

    let time = pack $ formatTime defaultTimeLocale "%B %Y" currentTime

    TIO.writeFile fp
        $   header time
        <> T.concat (bookEntry <$> books)

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


-- prepend :: Text -> Text -> Text
-- prepend a b = a <> b
