

module Main where

import           Domain.User
import           AWSLambda.Events.APIGateway
import           Text.Show.Pretty               ( pPrint )
import           Data.Text                      ( Text )
import           Control.Lens
import           Data.Aeson.Embedded
import           Data.Aeson                     ( encode )
import           UseCases.GetUser.UseCase
import qualified Data.HashMap.Strict           as HM
import           DBConfig
import           Fake.GatewayReq

main = apiGatewayMain handler

handler
  :: APIGatewayProxyRequest Text
  -> IO (APIGatewayProxyResponse (Embedded GetUserUseCaseRes))

handler evt = do
  let keys = evt ^. agprqPathParameters
  env  <- getEnvironment Local
  user <- getUserUseCase env keys
  case user of
    Nothing -> return responseNotFound
    Just u  -> return $ responseOK & responseBodyEmbedded ?~ u

