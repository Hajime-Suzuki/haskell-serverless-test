{-# LANGUAGE DeriveGeneric, DeriveAnyClass, TemplateHaskell, OverloadedStrings #-}

module UseCases.UpdateUser.Ports where

import           Data.Aeson.Embedded
import           Control.Lens
import           Data.Aeson
import           GHC.Generics
import           Data.Text                      ( Text )
import           Domain.User


data UpdateUserInput = UpdateUserInput {_inputFirstName:: Maybe Text, _inputLastName::Maybe Text} deriving(Show, Generic, FromJSON)

makeLenses ''UpdateUserInput


data UpdateUserUseCaseRes = UpdateUserUseCaseRes {user :: Text} deriving(ToJSON, Generic, Show)


data Res a = ErrorRes {error::String} | Res a deriving(ToJSON, Generic, Show)
