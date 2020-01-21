{-# LANGUAGE OverloadedStrings #-}

module Main where
import           AWSLambda.Events.APIGateway
import           User
import           Data.Aeson.Embedded
import           Data.Text                      ( Text )
import           Control.Lens
import           Fake.GatewayReq
import           DBConfig
import           CreateUserUseCase

main = handler createFakeReq

handler
  :: APIGatewayProxyRequest Text -> IO (APIGatewayProxyResponse (Embedded Text))
handler evt = do
  env <- getEnvironment Local
  createUserUseCase env
  return $ responseOK & responseBodyEmbedded ?~ "Test"
