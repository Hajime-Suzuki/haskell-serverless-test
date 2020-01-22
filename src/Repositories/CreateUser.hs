{-# LANGUAGE OverloadedStrings #-}

module Repositories.CreateUser where
import           Repositories.RequestHandler
import           Network.AWS.DynamoDB.PutItem
import           Control.Lens
import qualified Data.HashMap.Strict           as HM
import           Network.AWS.DynamoDB.Types
import           Data.Text                      ( Text )
import qualified Network.AWS.Env               as AWSEnv
import           Domain.User
import           Repositories.TransformUser

saveUser :: AWSEnv.Env -> User -> IO ()
saveUser env user = do
  res <- sendReq env q
  print $ res ^. pirsResponseStatus
 where
  entityValues = toDbEntity user
  q            = putItem "haskell-users" & piItem .~ entityValues

