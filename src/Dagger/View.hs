module Dagger.View (view) where

import Control.Lens ((^.))
import Miso (View, div_, text)
import Miso.String (ms)

import Dagger.Types

view :: State -> View Action
view s = div_ [] [text $ "Dagger: " <> ms (show $ s ^. sDag)]
