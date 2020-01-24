{-# LANGUAGE DeriveGeneric, DeriveAnyClass, OverloadedStrings #-}

module UseCases.UpdateUser.UseCase where

import           Domain.User
import           Data.Aeson
import           GHC.Generics
import           Control.Lens
import qualified Data.HashMap.Strict           as HM
import           Data.Text                      ( Text )
import           Repositories.TransformUser
import           Repositories.UpdateUser       as UserRepo
import           UseCases.UpdateUser.Ports
import qualified Network.AWS.Env               as AWSEnv

updateUsersUseCase :: AWSEnv.Env -> IO UpdateUsersUseCaseRes
updateUsersUseCase env = do
  UserRepo.updateUser env "1" (UpdateUserInput (Just "123") Nothing)
  return $ UpdateUsersUseCaseRes "test"

