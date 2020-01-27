{-# LANGUAGE  OverloadedStrings #-}

module UseCases.UpdateUser.UseCase where

import           Domain.User
import           Data.Aeson
import           GHC.Generics
import           Control.Lens
import qualified Data.HashMap.Strict           as HM
import           Data.Text                      ( Text )
import           Data.Maybe                     ( isNothing )
import           Repositories.TransformUser
import           Repositories.UpdateUser       as UserRepo
import           UseCases.UpdateUser.Ports
import qualified Network.AWS.Env               as AWSEnv


updateUsersUseCase
  :: AWSEnv.Env
  -> Maybe UpdateUserInput
  -> Maybe Text
  -> IO (Either String UpdateUserUseCaseRes)

updateUsersUseCase _ Nothing _ = return $ Left "input can not be empty"
updateUsersUseCase _ _ Nothing = return $ Left "user id can not be empty"

updateUsersUseCase env (Just input) (Just userId) = do
  UserRepo.updateUser env userId input
  return . Right $ UpdateUserUseCaseRes "updated"


