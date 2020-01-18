{-# LANGUAGE DeriveGeneric, DeriveAnyClass, DuplicateRecordFields, OverloadedStrings, TemplateHaskell #-}

module Repositories.User where

import           Control.Lens
import qualified Data.HashMap.Strict           as HM
import           Data.Text                      ( Text(..)
                                                , pack
                                                )
import           Data.Aeson
import           Data.Maybe                     ( fromJust
                                                , isNothing
                                                )
import           GHC.Generics


type PK = Text
type SK = Text
type FirstName = Text
type LastName = Text

data User = User {
  _pk :: PK,
  _sk :: SK,
  _firstName :: FirstName,
  _lastName :: LastName
} deriving(Show, Generic, ToJSON, FromJSON)

makeLenses ''User
