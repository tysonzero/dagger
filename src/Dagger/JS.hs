module Dagger.JS (main) where

import Language.Javascript.JSaddle (JSM)
import Miso
    ( App(App), LogLevel(..), defaultEvents, events, initialAction
    , div_, logLevel, model, mountPoint, startApp, subs, update
    )
import qualified Miso

main :: JSM ()
main = startApp $ App
    { model = ()
    , update = \() () -> pure ()
    , Miso.view = \() -> div_ [] ["Dagger"]
    , initialAction = ()
    , events = defaultEvents
    , logLevel = Off
    , mountPoint = Nothing
    , subs = []
    }
