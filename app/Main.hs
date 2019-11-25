module Main where

import qualified Data.Aeson                    as Aeson
import           User
import           GHC.Generics
import           Response
import           AWSLambda

main = lambdaMain handler

handler :: Aeson.Value -> IO Response
handler evt = do
  print evt
  return Response { statusCode = 200, body = "some test" }
