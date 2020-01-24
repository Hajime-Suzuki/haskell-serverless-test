{-# LANGUAGE DeriveGeneric, DeriveAnyClass #-}

module UseCases.UpdateUser.Ports where

import           Data.Aeson.Embedded
import           Control.Lens
import           Data.Aeson
import           GHC.Generics
import           Data.Text                      ( Text )
import           Domain.User


data UpdateUserInput = UpdateUserInput {inputFirstName:: Maybe Text, inputLastName::Maybe Text}


newtype UpdateUsersUseCaseRes = UpdateUsersUseCaseRes {user :: String} deriving(ToJSON, Generic, Show)
