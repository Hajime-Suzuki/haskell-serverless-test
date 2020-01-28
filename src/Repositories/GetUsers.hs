{-# LANGUAGE OverloadedStrings #-}

module Repositories.GetUsers where

import           Repositories.RequestHandler
import           Repositories.TransformUser
import qualified Network.AWS.Env               as AWSEnv
import           Domain.User
import           Network.AWS.DynamoDB.GetItem
import           Network.AWS.DynamoDB
import           Control.Lens
import           Text.Pretty.Simple             ( pPrint )
import qualified Data.HashMap.Strict           as HM

getUser :: AWSEnv.Env -> Keys -> IO (Maybe User)
getUser env keys = do
  res <- sendReq env req
  return . fromDbEntity $ res ^. girsItem
  where req = getItem "haskell-users" & giKey .~ keys


scanTable :: AWSEnv.Env -> IO [Maybe User]
scanTable env = do
  res <- sendReq env req
  return $ map fromDbEntity $ res ^. srsItems
  where req = scan "haskell-users"

getUsers :: AWSEnv.Env -> IO [Maybe User]
getUsers env = do
  res <- sendReq env req
  return $ map fromDbEntity $ res ^. qrsItems
 where
  req =
    query "haskell-users"
      &  qKeyConditionExpression
      ?~ keys
      &  qExpressionAttributeValues
      .~ values
  keys   = genQueryUsersKeys
  values = genQueryUsersValues "1"
