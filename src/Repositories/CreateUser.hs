{-# LANGUAGE OverloadedStrings #-}

module Repositories.CreateUser where
import           Repositories.RequestHandler
import           Network.AWS.DynamoDB.PutItem
import           Control.Lens
import qualified Data.HashMap.Strict           as HM
import           Network.AWS.DynamoDB.Types
import           Data.Text                      ( Text )
import qualified Network.AWS.Env               as AWSEnv

createUser :: AWSEnv.Env -> HM.HashMap Text AttributeValue -> IO ()
createUser env item = do
  res <- sendReq env q
  print $ res ^. pirsResponseStatus
  where q = putItem "haskell-users" & piItem .~ item
