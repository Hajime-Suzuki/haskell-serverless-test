{-# LANGUAGE DeriveGeneric, DeriveAnyClass, DuplicateRecordFields #-}

module User where
import           Data.Aeson
import           GHC.Generics

data User = User {
  userId :: Int,
  name :: String,
  email :: String,
  company :: Maybe Company,
  address :: Maybe Address
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


getUser = User
  { userId  = 1
  , name    = "my name"
  , email   = "test@email.com"
  , company = Nothing
  , address = Just Address { street  = "street1"
                           , city    = "city A"
                           , zipcode = "1234AB"
                           }
  }

data UserInput = UserInput {
  firstName:: String,
  lastName:: String
} deriving (Show , Generic, FromJSON)
