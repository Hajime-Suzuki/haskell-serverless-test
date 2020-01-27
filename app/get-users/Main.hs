{-# LANGUAGE OverloadedStrings #-}

module Main where

import           Domain.User
import           AWSLambda.Events.APIGateway
import           Text.Show.Pretty               ( pPrint )
import           Data.Text                      ( Text )
import           Control.Lens
import           Data.Aeson.Embedded
import           Data.Aeson                     ( encode )
import           UseCases.GetUsers.UseCase
import           UseCases.GetUsers.Ports
import qualified Data.HashMap.Strict           as HM
import           DBConfig
import           Fake.GatewayReq

main = handler fakeGatewayReq

handler
  :: APIGatewayProxyRequest Text
  -> IO (APIGatewayProxyResponse (Embedded GetUsersUseCaseRes))

handler evt = do
  env <- getEnvironment
  res <- getUsersUseCase env
  return $ responseOK & responseBodyEmbedded ?~ res

