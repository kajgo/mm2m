{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ExtendedDefaultRules #-}

module Mongo where

import Database.MongoDB
import Prelude hiding (lookup)

getVisitors :: IO (Either Failure Int)
getVisitors = do
   pipe <- runIOE $ connect (host "127.0.0.1")
   e <- access pipe master "test" run
   close pipe
   return e

run :: Action IO Int
run = do
    cursor <- find (select [] "visitors")
    docs <- rest cursor
    return $ length docs
