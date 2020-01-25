{-# LANGUAGE DeriveGeneric, DeriveAnyClass, TemplateHaskell #-}

module UseCases.UpdateUser.Ports where

import           Data.Aeson.Embedded
import           Control.Lens
import           Data.Aeson
import           GHC.Generics
import           Data.Text                      ( Text )
import           Domain.User


data UpdateUserInput = UpdateUserInput {_inputFirstName:: Maybe Text, _inputLastName::Maybe Text} deriving(Show)

makeLenses ''UpdateUserInput


newtype UpdateUsersUseCaseRes = UpdateUsersUseCaseRes {user :: String} deriving(ToJSON, Generic, Show)
