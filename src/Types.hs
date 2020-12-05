module Types where

import Data.Text
import Data.Time.Clock (UTCTime)

data Book = Book
    { title      :: Text
    , author     :: Text
    , highlights :: [Highlight]
    } deriving (Show, Eq)


data Highlight = Highlight
    { highlight   :: Text
    , note        :: Maybe Text
    , date        :: Text
    } deriving (Show, Eq)
