{-# LANGUAGE DeriveGeneric, DeriveAnyClass, DuplicateRecordFields #-}

module User where
import           Data.Aeson
import           GHC.Generics

data User = User {
  userId :: Int,
  name :: String,
  email :: Int,
  company :: Company,
  address :: Address
} deriving (Show, Generic, ToJSON, FromJSON)

data Company = Company {
  name ::  String,
  catchPhrase :: String
} deriving (Show, Generic, ToJSON, FromJSON)


data Address = Address {
  street :: String,
  city :: String,
  zipcode :: String
} deriving (Show, Generic, ToJSON, FromJSON)
