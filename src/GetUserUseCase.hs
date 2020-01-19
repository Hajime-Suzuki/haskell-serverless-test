{-# LANGUAGE DeriveGeneric, DeriveAnyClass, OverloadedStrings #-}

module GetUserUseCase where

import           Repositories.User
import qualified Network.AWS.Env               as AWSEnv
import           Data.Aeson
import           GHC.Generics
import           Control.Lens
import qualified Data.HashMap.Strict           as HM
import           Network.AWS.DynamoDB.GetItem
import           Network.AWS.DynamoDB
import           Repositories.RequestHandler
import           Repositories.TransformUser
import           Data.Text                      ( Text
                                                , splitOn
                                                )

data GetUserUseCaseRes = GetUserUseCaseRes {user :: Maybe User} deriving (Generic, ToJSON, Show)

type Keys = HM.HashMap Text AttributeValue

genGetUserKeys :: Text -> Keys
genGetUserKeys pk = HM.fromList
  [("PK", attributeValue & avS ?~ pk), ("SK", attributeValue & avS ?~ "user")]

-- TODO: change Keys to Maybe Keys
getUser :: AWSEnv.Env -> Keys -> IO (Maybe User)
getUser env keys = do
  res <- sendReq env req
  -- let user = deserializeUser $ res ^. girsItem
  -- return user
  return $ deserializeUser $ res ^. girsItem
  where req = getItem "haskell-users" & giKey .~ keys


getUserUseCase
  :: AWSEnv.Env -> HM.HashMap Text Text -> IO (Maybe GetUserUseCaseRes)
getUserUseCase env keys = case keys ^? ix "userId" of
  Nothing     -> return Nothing
  Just userId -> do
    let getUserKeys = genGetUserKeys userId
    user <- getUser env getUserKeys
    return $ Just (GetUserUseCaseRes user)

