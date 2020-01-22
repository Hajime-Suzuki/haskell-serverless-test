{-# LANGUAGE DuplicateRecordFields, OverloadedStrings #-}

module Repositories.TransformUser where

import           Network.AWS.DynamoDB
import           Control.Lens
import           Domain.User
import qualified Data.HashMap.Strict           as HM
import           Data.Text                      ( Text(..) )
import           Data.Maybe                     ( fromJust
                                                , isNothing
                                                )

type Keys = HM.HashMap Text AttributeValue
genGetUserKeys :: Text -> Keys
genGetUserKeys pk = HM.fromList
  [("PK", attributeValue & avS ?~ pk), ("SK", attributeValue & avS ?~ "user")]


fromDbEntity :: HM.HashMap Text AttributeValue -> Maybe User
fromDbEntity item = if null item
  then Nothing
  else Just User { _pk        = fromJust $ item ^. ix "PK" . avS
                 , _sk        = fromJust $ item ^. ix "SK" . avS
                 , _firstName = fromJust $ item ^. ix "firstName" . avS
                 , _lastName  = fromJust $ item ^. ix "lastName" . avS
                 }



toDbEntity :: User -> HM.HashMap Text AttributeValue
toDbEntity user = HM.fromList
  [ ("PK"       , attributeValue & avS .~ user ^? pk)
  , ("SK"       , attributeValue & avS .~ user ^? sk)
  , ("firstName", attributeValue & avS .~ user ^? firstName)
  , ("lastName" , attributeValue & avS .~ user ^? lastName)
  ]
