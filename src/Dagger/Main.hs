module Dagger.Main (main) where

import Control.Monad.IO.Class (liftIO)
import qualified Data.Text.IO as T
import Data.Tagged (Tagged(Tagged))
import GHC.Generics (Generic)
import Lucid (Html, toHtmlRaw)
import Language.Javascript.JSaddle.Warp (jsaddleJs, jsaddleOr)
import Network.HTTP.Types (status200)
import Network.Wai (Application, responseLBS)
import Network.Wai.Handler.Warp (run)
import Network.WebSockets (defaultConnectionOptions)
import Servant (Get, Raw, serveDirectoryWebApp, (:>))
import Servant.API.Generic ((:-))
import Servant.Server.Generic (genericServe)
import Servant.HTML.Lucid (HTML)

import qualified Dagger.JS as J

main :: IO ()
main = do
    app <- jsaddleOr defaultConnectionOptions J.main server
    putStrLn "Running Dagger on localhost:3758"
    run 3758 app

server :: Application
server = genericServe $ Api
    { aHtml = liftIO $ toHtmlRaw <$> T.readFile "static/index.html"
    , aScript = Tagged . const . flip id
        $ responseLBS status200 [("Content-Type", "text/javascript")] (jsaddleJs False)
    , aStatic = serveDirectoryWebApp "static"
    }

data Api r = Api
    { aHtml :: r :- Get '[HTML] (Html ())
    , aScript :: r :- "script.js" :> Raw
    , aStatic :: r :- Raw
    } deriving (Generic)
