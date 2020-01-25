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

-- main = apiGatewayMain handler

main =
  handler
  -- $ createFakeReq (UpdateUserInput (Just "aaaa") Nothing) [("userId", "1234")]
          $ createFakeReq (UpdateUserInput (Just "aaaa") Nothing) []


handler
  :: APIGatewayProxyRequest (Embedded UpdateUserInput)
  -> IO (APIGatewayProxyResponse (Embedded (Res UpdateUserUseCaseRes)))

handler evt = do
  env <- getEnvironment Local
  res <- updateUsersUseCase env
                            (evt ^. requestBodyEmbedded)
                            (evt ^. agprqPathParameters . at "userId")
  case res of
    (Left  e  ) -> return $ responseOK & responseBodyEmbedded ?~ ErrorRes e
    (Right res) -> return $ responseOK & responseBodyEmbedded ?~ Res res

