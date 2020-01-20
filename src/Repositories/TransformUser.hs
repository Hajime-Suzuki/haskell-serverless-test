{-# LANGUAGE DuplicateRecordFields, OverloadedStrings #-}

module Repositories.TransformUser where

import           Network.AWS.DynamoDB
import           Control.Lens
import           User
import qualified Data.HashMap.Strict           as HM
import           Data.Text                      ( Text(..) )
-- import           Data.Aeson
import           Data.Maybe                     ( fromJust
                                                , isNothing
                                                )
-- import           GHC.Generics



-- TODO: make this better 

deserializeUser :: HM.HashMap Text AttributeValue -> Maybe User
deserializeUser item = createUser (item ^. ix "PK" . avS)
                                  (item ^. ix "PK" . avS)
                                  (item ^. ix "firstName" . avS)
                                  (item ^. ix "lastName" . avS)


createUser
  :: Maybe PK -> Maybe SK -> Maybe FirstName -> Maybe LastName -> Maybe User
createUser pk sk firstName lastName
  | any isNothing [pk, sk, firstName, lastName] = Nothing
  | otherwise = Just User { _pk        = fromJust pk
                          , _sk        = fromJust sk
                          , _firstName = fromJust firstName
                          , _lastName  = fromJust lastName
                          }

type Keys = HM.HashMap Text AttributeValue
genGetUserKeys :: Text -> Keys
genGetUserKeys pk = HM.fromList
  [("PK", attributeValue & avS ?~ pk), ("SK", attributeValue & avS ?~ "user")]
