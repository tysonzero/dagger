module Dagger.JS (main) where

import Language.Javascript.JSaddle (JSM)
import Miso
    ( App(App), LogLevel(..), defaultEvents, events, initialAction
    , logLevel, model, mountPoint, startApp, subs, update
    )
import qualified Miso

import Dagger.Handler
import Dagger.Types
import Dagger.View

main :: JSM ()
main = startApp $ App
    { model = initial
    , update = handler
    , Miso.view = view
    , initialAction = NoOp
    , events = defaultEvents
    , logLevel = Off
    , mountPoint = Nothing
    , subs = []
    }
