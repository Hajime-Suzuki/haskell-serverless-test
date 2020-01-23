
module Main where
import           AWSLambda.Events.APIGateway
import           Domain.User
import           Data.Aeson.Embedded
import           Data.Text                      ( Text )
import           Control.Lens
import           Fake.GatewayReq
import           DBConfig
import           UseCases.CreateUser.UseCase
import qualified Data.ByteString.Lazy          as BL
import           Text.Show.Pretty
import           UseCases.CreateUser.Ports

main = apiGatewayMain handler
-- main = handler . createFakeReq $ CreateUserInput "Jane" "Doe"

handler
  :: APIGatewayProxyRequest (Embedded CreateUserInput)
  -> IO (APIGatewayProxyResponse (Embedded CreateUserRes))
handler evt = do
  env <- getEnvironment Local
  res <- createUserUseCase env (evt ^. requestBodyEmbedded)
  return $ responseOK & responseBodyEmbedded ?~ res
