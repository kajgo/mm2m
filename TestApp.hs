module TestApp where

import Happstack.Lite
import Mongo
import Control.Monad.IO.Class

testApp :: ServerPart Response
testApp = msum
    [ dir "register_visitor" $ registerVisitorPage
    , homePage
    ]

homePage :: ServerPart Response
homePage = do
    visitors <- liftIO getVisitors
    case visitors of
        Right visitors -> ok $ toResponse $ show visitors
        Left _ -> ok $ toResponse "fail"

registerVisitorPage :: ServerPart Response
registerVisitorPage = do
    liftIO registerVisitor
    ok $ toResponse "Visit registerd."
