{-# LANGUAGE OverloadedStrings #-}

module UseCases.CreateUser.UseCase where
import           Repositories.RequestHandler
import           Control.Lens
import qualified Data.HashMap.Strict           as HM
import           Network.AWS.DynamoDB.Types
import qualified Repositories.CreateUser       as UserRepo
import qualified Network.AWS.Env               as AWSEnv
import           UseCases.CreateUser.Ports
import           Domain.User
import           Text.Show.Pretty               ( pPrint )

createUserUseCase :: AWSEnv.Env -> Maybe CreateUserInput -> IO CreateUserRes
createUserUseCase env input = case input of
  Just input -> do
    let userData =
          parseUserInput (input ^? inputFirstName) (input ^? inputLastName)
    UserRepo.saveUser env userData
    return $ CreateUserRes True
  Nothing -> error "body is invalid"

