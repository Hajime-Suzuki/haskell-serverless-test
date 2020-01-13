{-# LANGUAGE CPP ,OverloadedStrings#-}

module ENV where

import           System.Directory               ( canonicalizePath )
import           System.FilePath.Posix          
import           Configuration.Dotenv
import           Data.Monoid 
import           Network.AWS.Types
import           Network.AWS
import           Network.AWS.DynamoDB           ( dynamoDB )
import           Control.Lens

loadSecrets = do
  envPath <- canonicalizePath $ takeDirectory __FILE__ </> "../.env"
  loadFile $ Config [envPath] [] False

data EndPointType = Local | AWS

getEnvironment :: EndPointType -> IO Env
getEnvironment Local = do
  let dynamo = setEndpoint False "localhost" 8000 dynamoDB
  newEnv Discover <&> configure dynamo <&> envRegion .~ Frankfurt

getEnvironment AWS = newEnv Discover <&> envRegion .~ Frankfurt