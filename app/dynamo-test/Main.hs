{-# LANGUAGE OverloadedStrings #-}

module Main where

import           Data.Aeson
import           GHC.Generics
import           Network.AWS.DynamoDB.GetItem
import           Network.AWS.DynamoDB
import           Network.AWS
import           Control.Lens
import qualified Data.HashMap.Strict           as HM
import           Control.Monad.Trans.AWS        ( runAWST )
import           Text.Show.Pretty               ( pPrint )
import           DBConfig                       ( loadSecrets
                                                , getEnvironment
                                                , EndPointType(..)
                                                )
import           Repositories.RequestHandler
import           Debug.Trace                    ( trace )
import           Repositories.TransformUser
import           Domain.User


scanTest :: Env -> IO [Maybe User]
scanTest env = do
  res <- sendReq env req
  let users = map fromDbEntity $ res ^. srsItems
  return users
  where req = scan "haskell-users"

getItemTest env = do
  res <- sendReq env req
  let user = fromDbEntity $ res ^. girsItem
  return user
 where
  req  = getItem "haskell-users" & giKey .~ keys
  keys = HM.fromList
    [ ("PK", attributeValue & avS ?~ "PK 2")
    , ("SK", attributeValue & avS ?~ "SK 2")
    ]


main = do
  loadSecrets
  env   <- getEnvironment
  users <- scanTest env
  user  <- getItemTest env
  putStrLn "\n === user ==="
  pPrint user
  putStrLn "\n === users ==="
  pPrint users
  return "DONE"

