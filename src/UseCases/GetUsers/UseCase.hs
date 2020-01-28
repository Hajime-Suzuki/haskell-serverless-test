{-# LANGUAGE DeriveGeneric, DeriveAnyClass, OverloadedStrings #-}

module UseCases.GetUsers.UseCase where

import           Domain.User
import           Data.Aeson
import           GHC.Generics
import           Control.Lens
import qualified Data.HashMap.Strict           as HM
import           Data.Text                      ( Text )
import           Repositories.TransformUser
import           Repositories.GetUsers
import           UseCases.GetUsers.Ports
import qualified Network.AWS.Env               as AWSEnv

type UserId = Text
getUsersUseCase
  :: AWSEnv.Env -> Maybe UserId -> IO (Either String GetUsersUseCaseRes)

getUsersUseCase _   Nothing       = return $ Left "user id can not be empty"
getUsersUseCase env (Just userId) = do
  users <- getUsers env userId
  return $ Right (GetUsersUseCaseRes users)
