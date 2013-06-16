module TestApp where

import Happstack.Lite
import Mongo
import Control.Monad.IO.Class

testApp :: ServerPart Response
testApp = msum [ homePage ]

homePage :: ServerPart Response
homePage = do
    hello <- liftIO sayHello
    visitors <- liftIO getVisitors
    ok $ toResponse $ show visitors

getVisitors :: IO Integer
getVisitors = do
    return 3

sayHello :: IO String
sayHello = do
    result <- returnHello
    case result of
        Right xs -> return (head xs)
        Left _ -> return "no"
