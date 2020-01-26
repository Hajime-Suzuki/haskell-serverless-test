{-# LANGUAGE DeriveGeneric #-}

module Utils.APIGateway where

import           Data.Aeson.Embedded
import           Control.Lens
import           Data.Aeson
import           GHC.Generics

data Response a = ErrorRes {error::String} | Success a deriving(Generic, Show)

instance (ToJSON a)=> ToJSON (Response a) where
  toJSON = genericToJSON defaultOptions { sumEncoding = UntaggedValue }
