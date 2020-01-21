{-# LANGUAGE DeriveGeneric, DeriveAnyClass, DuplicateRecordFields, OverloadedStrings, TemplateHaskell #-}

module Fake.GatewayReq where
import           AWSLambda.Events.APIGateway
import qualified Data.HashMap.Strict           as HM
import           Data.Aeson.TextValue
import           Data.Aeson
import           Data.Text                      ( Text
                                                , pack
                                                )
import           Domain.User
import           Data.Text.Encoding
-- import           Data.ByteString.Lazy           ( pack
--                                                 , unpack
--                                                 )
import           Data.Aeson.TextValue
import           GHC.Generics
-- import           Data.String.Conversions
import qualified Data.Text.Lazy.Encoding       as LE
import           Data.Aeson.Embedded
import           Control.Lens
import           UseCases.CreateUser.Ports

reqId = RequestIdentity Nothing
                        Nothing
                        Nothing
                        Nothing
                        Nothing
                        Nothing
                        Nothing
                        Nothing
                        Nothing
                        Nothing
                        Nothing

ctx = ProxyRequestContext { _prcPath         = Nothing
                          , _prcAccountId    = "1234"
                          , _prcResourceId   = "1234"
                          , _prcStage        = "stage"
                          , _prcRequestId    = "reqid"
                          , _prcIdentity     = reqId
                          , _prcResourcePath = "path"
                          , _prcHttpMethod   = "m"
                          , _prcApiId        = "api"
                          , _prcProtocol     = "http"
                          , _prcAuthorizer   = Nothing
                          }

fakeGatewayReq = APIGatewayProxyRequest
  { _agprqResource              = "test"
  , _agprqPath                  = "asht"
  , _agprqHttpMethod            = "some"
  , _agprqHeaders               = []
  , _agprqQueryStringParameters = []
  , _agprqPathParameters        = HM.fromList [("userId", "1")]
  , _agprqStageVariables        = HM.empty
  , _agprqRequestContext        = ctx
  , _agprqBody                  = Nothing
  }


createFakeReq body = APIGatewayProxyRequest
  { _agprqResource              = "test"
  , _agprqPath                  = "asht"
  , _agprqHttpMethod            = "some"
  , _agprqHeaders               = []
  , _agprqQueryStringParameters = []
  , _agprqPathParameters        = HM.fromList [("userId", "1")]
  , _agprqStageVariables        = HM.empty
  , _agprqRequestContext        = ctx
  , _agprqBody                  = Just (TextValue . Embedded $ body)
  }
