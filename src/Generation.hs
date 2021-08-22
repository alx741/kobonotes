{-# LANGUAGE OverloadedStrings #-}

module Generation
    ( readBook
    ) where

import           Data.Bool    (bool)
import           Data.Maybe   (isJust)
import           Data.Text as T
import qualified Data.Text.IO as TIO
<<<<<<< Updated upstream
import Data.Time.Format
import Data.Time
=======
import Text.Pandoc
import Data.Map.Strict
import Data.Time.Clock (UTCTime)
import Data.Time.Format (formatTime, defaultTimeLocale)
>>>>>>> Stashed changes

import Types

-- readBooks :: PandocMonad m => [Book] -> m Pandoc
-- readBooks books = undefined

<<<<<<< Updated upstream
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
=======

readBook :: PandocMonad m => Book -> m Pandoc
readBook book = do
    time <- getCurrentTime
    pure $ Pandoc (meta time) [(Para [Str "test"])]
    where
        meta time = Meta $ fromList
            [ ("title",  MetaString "Highlights & Notes")
            , ("author", MetaString "kobonotes.sillybytes.net")
            , ("date",   MetaString $ yearMonthFormatter time)
            ]

        yearMonthFormatter :: UTCTime -> Text
        yearMonthFormatter = pack . formatTime defaultTimeLocale "%B %Y"


-- writeMarkdown :: FilePath -> [Book] -> IO ()
-- writeMarkdown fp books = TIO.writeFile fp
--     $   header
--     <> T.concat (bookEntry <$> books)

-- bookEntry :: Book -> Text
-- bookEntry (Book title author highlights)
--     =  "\n\n\n"
--     <> "# "  <> title  <> "\n"
--     <> "## " <> author <> "\n\n"
--     <> T.concat (highlightEntry <$> highlights)
--     <> "-------"

-- highlightEntry :: Highlight -> Text
-- highlightEntry (Highlight highl note date)
--     =  "\n"
--     <> (stripEnd . T.unlines) (("> " <>) . stripStart <$> T.lines highl)
--     <> "   *" <> date <> "*" <> "\n"
--     <> maybe "" ("\n| " <>) note''
--     <> "\n"
--     where note' = strip <$> note
--           note'' = case note' of
--                         Just    "" -> Nothing
--                         Just    n  -> Just n
--                         Nothing    -> Nothing

-- header :: Text
-- header = "---\n"
--        <> "title: Kobo highlights & notes\n"
--        <> "...\n"
--        <> "\n"
--        <> "\\tableofcontents\n"


-- -- prepend :: Text -> Text -> Text
-- -- prepend a b = a <> b
>>>>>>> Stashed changes
