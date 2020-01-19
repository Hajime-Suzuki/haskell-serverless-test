{-# LANGUAGE OverloadedStrings #-}

module Fake.GatewayReq where
import           AWSLambda.Events.APIGateway
import qualified Data.HashMap.Strict           as HM

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

gatewayReq = APIGatewayProxyRequest "test"
                                    "asht"
                                    "some"
                                    [("h1", "asht")]
                                    [("q", Just "asht")]
                                    HM.empty
                                    HM.empty
                                    ctx
                                    Nothing
