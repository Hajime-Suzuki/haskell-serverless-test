{-# LANGUAGE OverloadedStrings #-}

module CreateUserUseCase where
import           Repositories.RequestHandler
import           Control.Lens
import qualified Data.HashMap.Strict           as HM
import           Network.AWS.DynamoDB.Types
import           Repositories.CreateUser
import qualified Network.AWS.Env               as AWSEnv

type CreateUserUseCaseReq = AWSEnv.Env
type CreateUserUseCaseRes = IO ()

item = HM.fromList
  [ ("PK"       , attributeValue & avS .~ Just "1234")
  , ("SK"       , attributeValue & avS .~ Just "9876")
  , ("firstName", attributeValue & avS .~ Just "new user")
  , ("lastName" , attributeValue & avS .~ Just "test")
  , ("age"      , attributeValue & avN .~ Just "1234")
  ]

createUserUseCase :: CreateUserUseCaseReq -> CreateUserUseCaseRes
createUserUseCase env = createUser env item
