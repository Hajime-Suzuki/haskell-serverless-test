{-# LANGUAGE DeriveGeneric, DeriveAnyClass, DuplicateRecordFields, OverloadedStrings #-}

module Main where

import           Data.Aeson
import           User
import           GHC.Generics
import           Response
import           AWSLambda
import           Data.ByteString.Lazy.UTF8     as BLU

main = lambdaMain handler

d = Body { success = True, test = "1234" }
handler :: Value -> IO Response

handler evt = do
  let b = encode d
  pure Response { statusCode = 200, body = BLU.toString b }
