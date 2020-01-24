{-# LANGUAGE OverloadedStrings #-}

module Repositories.UpdateUser where

import           Repositories.RequestHandler
import           Repositories.TransformUser
import qualified Network.AWS.Env               as AWSEnv
import           Domain.User
import           UseCases.UpdateUser.Ports
import           Network.AWS.DynamoDB.GetItem
import           Network.AWS.DynamoDB
import           Control.Lens
import qualified Data.HashMap.Strict           as HM




updateUser :: AWSEnv.Env -> PK -> UpdateUserInput -> IO ()
updateUser env pk input = do
  res <- sendReq env req
  print $ res ^. uirsResponseStatus
 where
  req =
    updateItem "haskell-users"
      &  uiKey
      .~ genGetUserKeys pk
      &  uiUpdateExpression
      ?~ "SET firstName = :updatedFirstName"
      &  uiExpressionAttributeValues
      .~ exprVal
  exprVal = HM.fromList
    [(":updatedFirstName", attributeValue & avS .~ inputFirstName input)]

