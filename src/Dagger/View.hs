module Dagger.View (view) where

import Control.Lens ((<&>), (^.))
import Data.Foldable (toList)
import Data.Map (Map)
import qualified Data.Map as M
import Miso (View, div_, style_, text)
import Miso.String (MisoString, ms)

import Dagger.Types

view :: State -> View Action
view s = nodeView $ s ^. sDag

nodeView :: Node -> View Action
nodeView = \case
    Null -> div_ [style_ $ nodeStyle "#DDDDDD"] ["Null"]
    Boolean b -> div_ [style_ $ nodeStyle "#DDFFDD"] [text . ms $ show b]
    Integer i -> div_ [style_ $ nodeStyle "#DDDDFF"] [text . ms $ show i]
    Float d -> div_ [style_ $ nodeStyle "#FFFFDD"] [text . ms $ show d]
    String t -> div_ [style_ $ nodeStyle "#FFDDDD"] [text $ ms t]
    Bytes b -> div_ [style_ $ nodeStyle "#FFDDFF"] [text . ms $ show b]
    List ns -> div_ [] $ zip [0 :: Int ..] (toList ns) <&> \(i, n) -> div_ []
        [ div_ [style_ $ nodeStyle "#DDDDFF"] [text . ms $ show i]
        , div_ [style_ layerStyle] [nodeView n]
        ]
    Map m -> div_ [] $ M.toList m <&> \(k, n) -> div_ []
        [ div_ [style_ $ nodeStyle "#FFDDDD"] [text $ ms k]
        , div_ [style_ layerStyle] [nodeView n]
        ]
    Link b -> div_ [style_ $ nodeStyle "#DDFFFF"] [text . ms $ show b]

layerStyle :: Map MisoString MisoString
layerStyle =
    [ ("margin-left", "20px")
    ]

nodeStyle :: MisoString -> Map MisoString MisoString
nodeStyle c =
    [ ("background-color", c)
    , ("display", "inline-block")
    , ("margin", "3px")
    , ("padding", "5px 10px")
    ]
