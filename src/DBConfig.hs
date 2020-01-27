{-# LANGUAGE CPP ,OverloadedStrings#-}

module DBConfig where

import           System.Directory               ( canonicalizePath )
import           System.FilePath.Posix          
import           Configuration.Dotenv
import           Data.Monoid 
import           Network.AWS.Types
import           Network.AWS
import           Network.AWS.DynamoDB           ( dynamoDB )
import           Control.Lens
import System.Environment (lookupEnv)

loadSecrets = do
  envPath <- canonicalizePath $ takeDirectory __FILE__ </> "../.env"
  loadFile $ Config [envPath] [] False

data EndPointType = Local | AWS

getEnvironment :: IO Env
getEnvironment = do
  isOffline <-  lookupEnv "IS_OFFLINE"
  case isOffline of 
    Nothing -> do
        let dynamo = setEndpoint False "localhost" 8000 dynamoDB
        newEnv Discover <&> configure dynamo <&> envRegion .~ Frankfurt
    (Just _) ->   newEnv Discover <&> envRegion .~ Frankfurt
