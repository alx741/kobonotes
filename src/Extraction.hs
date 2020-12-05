{-# LANGUAGE OverloadedStrings #-}

module Extraction where

import Data.List              (foldl', groupBy)
import Data.Text              hiding (foldl', groupBy)
import Database.SQLite.Simple
import Types


grandQuery = "SELECT Bookmark.VolumeID, Title, Attribution, Text, Annotation, Bookmark.DateCreated \
             \ FROM Bookmark \
             \ INNER JOIN content ON content.ContentID = Bookmark.VolumeID \
             \ ORDER BY Title ASC, Bookmark.DateCreated ASC"

extractBooks :: FilePath -> IO [Book]
extractBooks dbFp = do
    conn <- open dbFp
    xs <- query_ conn grandQuery
    pure $ booksFromRawData xs

booksFromRawData :: [(Text, Text, Text, Text, Maybe Text, Text)] -> [Book]
booksFromRawData rows =
    let booksRaw = groupBy (\(id1, _, _, _, _, _) (id2, _, _, _, _, _) -> id1 == id2) rows
    in parseBook <$> booksRaw

parseBook :: [(Text, Text, Text, Text, Maybe Text, Text)] -> Book
parseBook entries@((_,title,author,_,_,_):_) = foldl' insertEntry (Book title author []) entries
    where
        insertEntry :: Book -> (Text, Text, Text, Text, Maybe Text, Text) -> Book
        insertEntry book@(Book _ _ hs) (_,_,_,text,anno,date) =
            book { highlights = hs ++ [Highlight text anno date] }
