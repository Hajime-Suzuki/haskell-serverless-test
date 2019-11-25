{-# LANGUAGE DeriveGeneric, DeriveAnyClass, DuplicateRecordFields #-}

module Response where
import           Data.Aeson
import           GHC.Generics

data Response = Response {
    statusCode :: Int,
    body:: String
} deriving (Show, Generic, ToJSON, FromJSON)

data Body = Body {
    success :: Bool,
    test :: String
} deriving (Show, Generic, ToJSON, FromJSON)

