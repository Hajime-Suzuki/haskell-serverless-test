{-# LANGUAGE DeriveGeneric, DeriveAnyClass, DuplicateRecordFields #-}

module GetUserUseCase where

import           User
import           Data.Aeson
import           GHC.Generics

data GetUserUseCaseRes = GetUserUseCaseRes {user :: User} deriving (Generic, ToJSON)

getUserUseCase :: GetUserUseCaseRes
getUserUseCase = do
  let user = getUser
  GetUserUseCaseRes user
