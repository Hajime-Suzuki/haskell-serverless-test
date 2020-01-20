{-# LANGUAGE OverloadedStrings #-}

module Repositories.GetUsers where

import           Repositories.RequestHandler
import           Repositories.TransformUser
import qualified Network.AWS.Env               as AWSEnv
import           User
import           Network.AWS.DynamoDB.GetItem
import           Network.AWS.DynamoDB
import           Control.Lens

getUser :: AWSEnv.Env -> Keys -> IO (Maybe User)
getUser env keys = do
  res <- sendReq env req
  return $ deserializeUser $ res ^. girsItem
  where req = getItem "haskell-users" & giKey .~ keys
