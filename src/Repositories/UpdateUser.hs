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
import           Data.Maybe                     ( catMaybes
                                                , isJust
                                                )
import           Text.Show.Pretty
import           Data.Text                      ( Text
                                                , pack
                                                )
import           Data.List                      ( intercalate )

-- TODO: skip update if input is empty
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
      ?~ updateExpression
      &  uiExpressionAttributeValues
      .~ values
  updateExpression = pack (getUpdateUserExpression input)
  values           = getUpdateUserExpressionValues input

getUpdateUserExpression :: UpdateUserInput -> String
getUpdateUserExpression input = "SET "
  ++ intercalate ", " (filter (not . null) [fn, ln])
 where
  fn = if isJust (input ^. inputFirstName)
    then "firstName = :updatedFirstName"
    else ""
  ln = if isJust (input ^. inputLastName)
    then "lastName = :updatedLastName"
    else ""


-- make update condition dynamic
getUpdateUserExpressionValues
  :: UpdateUserInput -> HM.HashMap Text AttributeValue
getUpdateUserExpressionValues = filterMap . getValues

filterMap :: HM.HashMap Text AttributeValue -> HM.HashMap Text AttributeValue
filterMap = HM.filterWithKey helper
 where
  helper ":updatedFirstName" v = isJust (v ^. avS)
  helper ":updatedLastName"  v = isJust (v ^. avS)

getValues :: UpdateUserInput -> HM.HashMap Text AttributeValue
getValues input =
  HM.empty
    &  at ":updatedFirstName"
    ?~ (attributeValue & avS .~ input ^. inputFirstName)

    &  at ":updatedLastName"
    ?~ (attributeValue & avS .~ input ^. inputLastName)


