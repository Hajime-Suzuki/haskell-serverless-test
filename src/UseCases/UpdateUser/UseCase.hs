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
import           Text.Show.Pretty               ( pPrint )

updateUsersUseCase
  :: AWSEnv.Env
  -> Maybe UpdateUserInput
  -> HM.HashMap Text Text
  -> IO UpdateUsersUseCaseRes

updateUsersUseCase env input pathParams = case input of
  Nothing      -> error "input can not be empty"
  (Just input) -> case userId of
    Nothing       -> error "user id can not be empty"
    (Just userId) -> do
      UserRepo.updateUser env userId input
      return $ UpdateUsersUseCaseRes "updated"
  where userId = pathParams ^. at "userId"
