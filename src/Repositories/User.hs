{-# LANGUAGE DeriveGeneric, DeriveAnyClass, DuplicateRecordFields #-}

module Repositories.User where

import           Data.Aeson
import           GHC.Generics


data User = User {
  pk :: String,
  sk :: String,
  firstName :: String,
  lastName :: String
} deriving(Show, Generic, ToJSON, FromJSON)

-- getUser = 
