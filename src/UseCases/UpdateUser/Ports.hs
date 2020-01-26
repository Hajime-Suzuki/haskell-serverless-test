{-# LANGUAGE DeriveGeneric, DeriveAnyClass, TemplateHaskell, OverloadedStrings #-}

module UseCases.UpdateUser.Ports where

import           Data.Aeson.Embedded
import           Control.Lens
import           Data.Aeson
import           GHC.Generics
import           Data.Text                      ( Text )
import           Data.Char                      ( toLower )


data UpdateUserInput = UpdateUserInput {_inputFirstName:: Maybe Text, _inputLastName::Maybe Text} deriving(Show, Generic)

instance FromJSON UpdateUserInput where
  parseJSON = genericParseJSON defaultOptions
    { fieldLabelModifier = \key -> let (x : xs) = drop 6 key in toLower x : xs
    }

makeLenses ''UpdateUserInput

data UpdateUserUseCaseRes = UpdateUserUseCaseRes {user :: Text} deriving(ToJSON, Generic, Show)
