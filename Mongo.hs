{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ExtendedDefaultRules #-}

module Mongo where

import Database.MongoDB
import Prelude hiding (lookup)

getVisitors :: IO (Either Failure Int)
getVisitors = withTestDb $ do
    cursor <- find (select [] visitorsCollection)
    docs <- rest cursor
    return $ length docs

registerVisitor :: IO (Either Failure ())
registerVisitor = withTestDb $ do
    let doc = []
    insert_ visitorsCollection doc

withTestDb :: (Action IO a) -> IO (Either Failure a)
withTestDb run = do
    pipe <- runIOE $ connect (host "127.0.0.1")
    e <- access pipe master "test" run
    close pipe
    return e

visitorsCollection = "visitors"
