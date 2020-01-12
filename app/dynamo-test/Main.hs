{-# LANGUAGE DeriveGeneric, DeriveAnyClass, DuplicateRecordFields, OverloadedStrings #-}

module Main where

import           Data.Aeson
import           GHC.Generics
import           Network.AWS.DynamoDB.Scan
import           Network.AWS.DynamoDB
import           Network.AWS.Types
import           Network.AWS
import           Network.AWS.Endpoint           ( setEndpoint )
import           Control.Lens
import           Control.Monad.Trans.AWS        ( runAWST )
import           Data.ByteString                ( ByteString )

data DBInfo = DBInfo
    { env :: Env
    , service :: Service
    , region :: Region
    , tableName :: String
    }

type HostName = ByteString
type Port = Int
data ServiceType = AWS Region | Local HostName Port

-- https://blog.rcook.org/blog/2017/aws-via-haskell/

getDBInfo :: ServiceType -> IO DBInfo
getDBInfo serviceType = do
  env <- newEnv $ FromEnv "AWS_ACCESS_KEY_ID"
                          "AWS_SECRET_ACCESS_KEY"
                          Nothing
                          (Just "Frankfurt")

  let (service, region) = serviceRegion serviceType

  return $ DBInfo env service region "haskell-dynamo-test"
  where serviceRegion (AWS region) = (dynamoDB, region)
  -- serviceRegion (Local hostName port) =
  --   (setEndpoint False "localhost" 8000 dynamoDB, Frankfurt)

scanTest :: DBInfo -> IO (Maybe Int)
scanTest db = do
  let e = env db
  print $ view envRegion e
  print $ tableName db
  print $ region db

  res <- runResourceT . runAWS e . within Frankfurt $ send
    (scan "haskell-dynamo-test")

  print res

  return $ Just 1



-- withDynamoDB :: (HasEnv r, MonadBaseControl IO m) =>
--     r
--     -> Service
--     -> Region
--     -> AWST' r (ResourceT m) a
--     -> m a

-- withDynamoDB env service region action =
--   runResourceT . runAWST env . within region $ do
--     reconfigure service action

-- doPutItem :: DBInfo -> Int -> IO ()
-- doPutItem DBInfo{..} value = withDynamoDB env service region $ do
--     void $ send $ putItem tableName
--         & piItem .~ item
--     where item = HashMap.fromList
--             [ ("counter_name", attributeValue & avS .~ Just "my-counter")
--             , ("counter_value", attributeValue & avN .~ Just (intToText value))
--             ]

main = do
  db  <- getDBInfo $ AWS Frankfurt
  res <- scanTest db
  print res
