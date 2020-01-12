module Main where

import           User
import           AWSLambda.Events.APIGateway
import           Text.Show.Pretty               ( pPrint )
import           Data.Text                      ( Text )
import           Control.Lens
import           Data.Aeson.Embedded
import           GetUserUseCase

main = apiGatewayMain handler

handler
  :: APIGatewayProxyRequest Text
  -> IO (APIGatewayProxyResponse (Embedded GetUserUseCaseRes))

handler _ = do
  let user    = getUserUseCase
  return $ responseOK & responseBodyEmbedded ?~ user

