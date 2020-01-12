{-# LANGUAGE OverloadedStrings #-}

module S3Test where

import           Control.Lens
import           Network.AWS
import           Network.AWS.S3
import           System.IO
import           Text.Show.Pretty

example :: IO ListBucketsResponse
example = do
  let credentials = FromEnv "AWS_ACCESS_KEY_ID"
                            "AWS_SECRET_ACCESS_KEY"
                            Nothing
                            (Just "Frankfurt")
  e <- newEnv credentials
  runResourceT . runAWS e $ send listBuckets


printBuckets :: IO ()
printBuckets = do
  ex <- example
  pPrint "s3 buckets"
  pPrint $ [ x ^. bName | x <- ex ^. lbrsBuckets ]

s3Test :: IO ()
s3Test = printBuckets
