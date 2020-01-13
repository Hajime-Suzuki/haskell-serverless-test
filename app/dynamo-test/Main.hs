{-# LANGUAGE DeriveGeneric, DeriveAnyClass, DuplicateRecordFields, OverloadedStrings, CPP #-}

module Main where

import           Data.Aeson
import           GHC.Generics
import           Network.AWS.DynamoDB.Scan
import           Network.AWS.DynamoDB
import           Network.AWS.Types
import           Network.AWS
import           Network.AWS.Endpoint           ( setEndpoint )
import           Control.Lens
import           Control.Monad.Trans.AWS        ( runAWST )
import           Data.ByteString                ( ByteString )
import           Text.Show.Pretty               ( pPrint )
import           ENV                            (loadSecrets)

-- https://blog.rcook.org/blog/2017/aws-via-haskell/

-- data Test = HashMap  {
--   id :: Int,
--   name :: String
-- }

data Test = Test {
  id :: Int,
  name :: String
} deriving (Show, Generic, ToJSON)



scanTest :: IO (Maybe Int)
scanTest = do
  env <- newEnv Discover
  let updated = env & envRegion .~ Frankfurt --TODO: avoid another var

  res <- runResourceT . runAWS updated $ send (scan "haskell-dynamo-test")

  pPrint $ res ^. srsItems

  return $ Just 1234567890

main = do
  loadSecrets
  res <- scanTest
  print res
