{-# LANGUAGE OverloadedStrings #-}

module Generation
    (writeMarkdown
    ) where

import           Data.Bool    (bool)
import           Data.Maybe   (isJust)
import           Data.Text as T
import qualified Data.Text.IO as TIO

import Types


writeMarkdown :: FilePath -> [Book] -> IO ()
writeMarkdown fp books = TIO.writeFile fp
    $   header
    <> T.concat (bookEntry <$> books)

bookEntry :: Book -> Text
bookEntry (Book title author highlights)
    =  "\n\n\n"
    <> "# "  <> title  <> "\n"
    <> "## " <> author <> "\n\n"
    <> T.concat (highlightEntry <$> highlights)

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

header :: Text
header = "---\n"
       <> "title: Kobo highlights & notes\n"
       <> "...\n"
       <> "\n"
       <> "\\tableofcontents\n"


-- prepend :: Text -> Text -> Text
-- prepend a b = a <> b
