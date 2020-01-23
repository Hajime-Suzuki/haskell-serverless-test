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

getUsersUseCase :: AWSEnv.Env -> IO GetUsersUseCaseRes

getUsersUseCase env = do
  users <- getUsers env
  print users
  return $ GetUsersUseCaseRes users
