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
import           Utils.APIGateway

main = apiGatewayMain handler
-- main = handler fakeGatewayReq

handler
  :: APIGatewayProxyRequest Text
  -> IO (APIGatewayProxyResponse (Embedded (Response GetUsersUseCaseRes)))

handler evt = do
  env <- getEnvironment
  let userId = evt ^. agprqPathParameters . at "userId"
  res <- getUsersUseCase env userId
  
  case res of
    (Left  e   ) -> return $ response 500 & responseBodyEmbedded ?~ ErrorRes e
    (Right user) -> return $ responseOK & responseBodyEmbedded ?~ Success user

