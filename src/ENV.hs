{-# LANGUAGE CPP #-}

module ENV where

import           System.Directory               ( canonicalizePath )
import           System.FilePath.Posix          
import           Configuration.Dotenv

loadSecrets = do
  envPath <- canonicalizePath $ takeDirectory __FILE__ </> "../.env"
  loadFile $ Config [envPath] [] False