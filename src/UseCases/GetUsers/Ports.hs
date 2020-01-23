{-# LANGUAGE DeriveGeneric, DeriveAnyClass #-}

module UseCases.GetUsers.Ports where

import           Data.Aeson.Embedded
import           Control.Lens
import           Data.Aeson
import           GHC.Generics
import           Data.Text                      ( Text )
import           Domain.User

newtype GetUsersUseCaseRes = GetUsersUseCaseRes {users :: [Maybe User]} deriving(ToJSON, Generic, Show)
