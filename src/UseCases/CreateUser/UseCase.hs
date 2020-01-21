{-# LANGUAGE OverloadedStrings #-}

module UseCases.CreateUser.UseCase where
import           Repositories.RequestHandler
import           Control.Lens
import qualified Data.HashMap.Strict           as HM
import           Network.AWS.DynamoDB.Types
import qualified Repositories.CreateUser       as UserRepo
import qualified Network.AWS.Env               as AWSEnv
import           UseCases.CreateUser.Ports
import qualified Domain.User                   as U
type CreateUserUseCaseRes = IO CreateUserRes

item = HM.fromList
  [ ("PK"       , attributeValue & avS .~ Just "1234")
  , ("SK"       , attributeValue & avS .~ Just "9876")
  , ("firstName", attributeValue & avS .~ Just "new user")
  , ("lastName" , attributeValue & avS .~ Just "test")
  , ("age"      , attributeValue & avN .~ Just "1234")
  ]

createUserUseCase :: AWSEnv.Env -> Maybe CreateUserInput -> CreateUserUseCaseRes
createUserUseCase env input = case input of
  Just input -> do
    let userData = U.parseUserInput (Just "test") (Just "value")
    print userData
    UserRepo.createUser env item
    pure $ CreateUserRes True
  Nothing -> error "body is invalid"

