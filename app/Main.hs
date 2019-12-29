{-# LANGUAGE DeriveGeneric, DeriveAnyClass, DuplicateRecordFields, OverloadedStrings #-}

module Main where

import           Data.Aeson
import           User
import           GHC.Generics
import           Response
import           AWSLambda
import           Data.ByteString.Lazy.UTF8      ( toString )
import           Text.Show.Pretty               ( pPrint )

main = lambdaMain handler

handler :: Value -> IO Response
handler evt = do
  let user = getUser
  pPrint evt
  Response.success user
