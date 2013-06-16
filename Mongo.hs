{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ExtendedDefaultRules #-}

module Mongo where

import Database.MongoDB
import Prelude hiding (lookup)

registerVisitor :: IO ()
registerVisitor = do
    pipe <- runIOE $ connect (host "127.0.0.1")
    e <- access pipe master "test" run
    close pipe
    return ()
    where
        run :: Action IO ()
        run = do
            let doc = []
            insert_ "visitors" doc

getVisitors :: IO (Either Failure Int)
getVisitors = do
    pipe <- runIOE $ connect (host "127.0.0.1")
    e <- access pipe master "test" run
    close pipe
    return e
    where
        run :: Action IO Int
        run = do
            cursor <- find (select [] "visitors")
            docs <- rest cursor
            return $ length docs
