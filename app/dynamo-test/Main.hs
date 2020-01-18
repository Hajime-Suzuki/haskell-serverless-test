{-# LANGUAGE OverloadedStrings #-}

module Main where

import           Data.Aeson
import           GHC.Generics
import           Network.AWS.DynamoDB.Scan
import           Network.AWS
import           Control.Lens
import           Control.Monad.Trans.AWS        ( runAWST )
import           Text.Show.Pretty               ( pPrint )
import           ENV                            ( loadSecrets
                                                , getEnvironment
                                                , EndPointType(..)
                                                )

import           Debug.Trace                    ( trace )
import           Repositories.TransformUser
import           Repositories.User


scanTest :: Env -> IO [Maybe User]
scanTest env = do
  res <- runResourceT . runAWS env $ send (scan "haskell-users")
  let users = deserializeUser $ res ^. srsItems
  return users


main = do
  loadSecrets
  env <- getEnvironment Local
  res <- scanTest env
  pPrint res
  return res
