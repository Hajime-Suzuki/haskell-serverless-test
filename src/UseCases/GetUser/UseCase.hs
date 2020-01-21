{-# LANGUAGE DeriveGeneric, DeriveAnyClass, OverloadedStrings #-}

module UseCases.GetUser.UseCase where

import           Domain.User
import           Data.Aeson
import           GHC.Generics
import           Control.Lens
import qualified Data.HashMap.Strict           as HM
import           Data.Text                      ( Text )
import           Repositories.TransformUser
import           Repositories.GetUsers
import qualified Network.AWS.Env               as AWSEnv

newtype GetUserUseCaseRes = GetUserUseCaseRes {user :: Maybe User} deriving (Generic, ToJSON, Show)

getUserUseCase
  :: AWSEnv.Env -> HM.HashMap Text Text -> IO (Maybe GetUserUseCaseRes)
getUserUseCase env keys = case keys ^? ix "userId" of
  Nothing     -> error "user id is missing"
  Just userId -> do
    let getUserKeys = genGetUserKeys userId
    user <- getUser env getUserKeys
    return $ Just (GetUserUseCaseRes user)
