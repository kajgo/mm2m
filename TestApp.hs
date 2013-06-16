module TestApp where

import Happstack.Lite
import Mongo
import Control.Monad.IO.Class

testApp :: ServerPart Response
testApp = msum [ homePage ]

homePage :: ServerPart Response
homePage = do
    visitors <- liftIO getVisitors
    case visitors of
        Right visitors -> ok $ toResponse $ show visitors
        Left _ -> ok $ toResponse "fail"
