{-# LANGUAGE DeriveGeneric, DeriveAnyClass, DuplicateRecordFields #-}

module Response
    ( success
    , Response
    )
where
import           Data.Aeson
import           GHC.Generics
import qualified Data.ByteString.Lazy          as B
import           Data.ByteString.Lazy.UTF8      ( toString )

data Response = Response {
    statusCode :: Int,
    body :: String
} deriving(Show, Generic, ToJSON, FromJSON)

success :: (ToJSON a) => a -> IO Response
success body =
    pure Response { statusCode = 200, body = toString . encode $ body }
