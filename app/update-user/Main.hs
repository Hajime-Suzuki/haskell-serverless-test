{-# LANGUAGE OverloadedStrings #-}

module Main where

import           Domain.User
import           AWSLambda.Events.APIGateway
import           Text.Show.Pretty               ( pPrint )
import           Data.Text                      ( Text )
import           Control.Lens
import           Data.Aeson.Embedded
import           Data.Aeson                     ( encode )
import           UseCases.UpdateUser.UseCase
import           UseCases.UpdateUser.Ports
import qualified Data.HashMap.Strict           as HM
import           DBConfig
import           Fake.GatewayReq

main = handler fakeGatewayReq

handler
  :: APIGatewayProxyRequest Text
  -> IO (APIGatewayProxyResponse (Embedded UpdateUsersUseCaseRes))

handler evt = do
  env <- getEnvironment Local
  res <- updateUsersUseCase env
  return $ responseOK & responseBodyEmbedded ?~ res

