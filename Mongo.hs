{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ExtendedDefaultRules #-}

module Mongo where

import Database.MongoDB
import Prelude hiding (lookup)

main = do
    hello <- returnHello
    print hello

returnHello :: IO (Either Failure [String])
returnHello = do
   pipe <- runIOE $ connect (host "127.0.0.1")
   e <- access pipe master "test" run
   close pipe
   return e

run :: Action IO [String]
run = do
    cursor <- find (select ["h" =: "hi"] "test")
    docs <- rest cursor
    mapM (lookup "h") docs
