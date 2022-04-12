module Dagger.View (view) where

import Control.Lens ((<&>), (^.))
import Data.Foldable (toList)
import Data.Map (Map)
import qualified Data.Map as M
import Miso (View, class_, div_, style_, text)
import Miso.String (MisoString, ms)

import Dagger.Types

view :: State -> View Action
view s = nodeView $ s ^. sDag

nodeView :: Node -> View Action
nodeView = \case
    Null -> div_ [class_ "bg-red-400 grid grid-cols-1 m-1 p-1"] ["Null"]
    Boolean b -> div_ [class_ "bg-red-400 m-1 p-1"] [text . ms $ show b]
    Integer i -> div_ [class_ "bg-red-400 grid grid-cols-1 m-1 p-1"] [text . ms $ show i]
    Float d -> div_ [class_ "bg-red-400 grid grid-cols-1 m-1 p-1"] [text . ms $ show d]
    String t -> div_ [class_ "bg-red-400 grid grid-cols-1 m-1 p-1"] [text $ ms t]
    Bytes b -> div_ [class_ "bg-red-400 grid grid-cols-1 m-1 p-1"] [text . ms $ show b]
    List ns -> div_ [class_ "bg-blue-400 bg-opacity-50"] $ zip [0 :: Int ..] (toList ns) <&> \(i, n) -> div_ [class_ "grid grid-cols-2"]
        [ div_ [class_ "bg-green-400 m-1 p-1"] [text . ms $ show i]
        , div_ [class_ ""] [nodeView n]
        ]
    Map m -> div_ [class_ "bg-indigo-400 bg-opacity-50"] $ M.toList m <&> \(k, n) -> div_ [class_ "grid grid-cols-2"]
        [ div_ [class_ "bg-yellow-400 grid grid-cols-1 m-1 p-1"] [text $ ms k]
        , div_ [class_ ""] [nodeView n]
        ]
    Link b -> div_ [style_ $ nodeStyle "#DDFFFF"] [text . ms $ show b]

nodeStyle :: MisoString -> Map MisoString MisoString
nodeStyle _ = []
