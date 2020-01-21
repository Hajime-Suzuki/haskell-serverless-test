{-# LANGUAGE DeriveGeneric, DeriveAnyClass, DuplicateRecordFields, OverloadedStrings, TemplateHaskell #-}

module UseCases.CreateUser.Ports where

import           Data.Aeson.Embedded
import           Control.Lens
import           Data.Aeson
import           GHC.Generics

data CreateUserInput = CreateUserInput {
    inputFirstName :: String,
    inputLastName :: String
} deriving (ToJSON, Generic, Show)

makeLenses ''CreateUserInput

newtype CreateUserRes = CreateUserRes {success :: Bool} deriving(ToJSON, Generic, Show)
