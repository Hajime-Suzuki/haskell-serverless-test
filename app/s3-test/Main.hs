{-# LANGUAGE OverloadedStrings #-}

module Main where

import           Control.Lens
import           Network.AWS
import           Network.AWS.S3
import           System.IO
import           Text.Show.Pretty

main = s3Test

example :: IO ListBucketsResponse
example = do
  lgr <- newLogger Debug stdout
  e   <- newEnv Discover
  runResourceT . runAWS (e & envLogger .~ lgr) $ send listBuckets


printBuckets :: IO ()
printBuckets = do
  ex <- example
  pPrint "s3 buckets"
  pPrint $ [ x ^. bName | x <- ex ^. lbrsBuckets ]

s3Test :: IO ()
s3Test = printBuckets
