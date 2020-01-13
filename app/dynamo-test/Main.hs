{-# LANGUAGE DeriveGeneric, DeriveAnyClass, DuplicateRecordFields, OverloadedStrings #-}

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
import           ENV                            ( loadSecrets
                                                , getEnvironment
                                                , EndPointType(..)
                                                )

-- https://blog.rcook.org/blog/2017/aws-via-haskell/

scanTest :: IO (Maybe Int)
scanTest = do

  env <- getEnvironment Local
  res <- runResourceT . runAWS env $ send (scan "haskell-users")

  pPrint $ res ^. srsItems

  return $ Just 1234567890

main = do
  loadSecrets
  res <- scanTest
  print res

