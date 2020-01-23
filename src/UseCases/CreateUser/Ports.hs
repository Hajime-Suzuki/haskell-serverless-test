{-# LANGUAGE DeriveGeneric, DeriveAnyClass, DuplicateRecordFields, OverloadedStrings, TemplateHaskell #-}

module UseCases.CreateUser.Ports where

import           Data.Aeson.Embedded
import           Control.Lens
import           Data.Aeson
import           GHC.Generics
import           Data.Text                      ( Text )

data CreateUserInput = CreateUserInput {
    _inputFirstName :: Text,
    _inputLastName :: Text
} deriving (ToJSON, FromJSON, Generic, Show)

makeLenses ''CreateUserInput

newtype CreateUserRes = CreateUserRes {success :: Bool} deriving(ToJSON, Generic, Show)
