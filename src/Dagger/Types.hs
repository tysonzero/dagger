{-# LANGUAGE TemplateHaskell #-}

module Dagger.Types
    ( State(..)
    , sDag
    , Node(..)
    , nValue
    , nSelected
    , NodeValue(..)
    , Action(..)
    , initial
    ) where

import Control.Lens.TH (makeLenses)
import Data.ByteString (ByteString)
import Data.Map (Map)
import Data.Text (Text)
import Data.Vector (Vector)

newtype State = State
    { _sDag :: Node
    } deriving (Eq, Show)

data Node = Node
    { _nValue :: NodeValue
    , _nSelected :: Bool
    } deriving (Eq, Show)

data NodeValue
    = Null
    | Boolean Bool
    | Integer Integer
    | Float Double
    | String Text
    | Bytes ByteString
    | List (Vector Node)
    | Map (Map Text Node)
    | Link ByteString
    deriving (Eq, Show)

makeLenses ''State
makeLenses ''Node

mkNode :: NodeValue -> Node
mkNode v = Node
    { _nValue = v
    , _nSelected = False
    }

data Action
    = Modify (State -> State)
    | NoOp

initial :: State
initial = State
    { _sDag = mkNode $ Map
      [ ( "bar"
        , Node
          { _nValue = List
            [ mkNode Null
            , mkNode $ Boolean True
            , mkNode $ List
              [ mkNode Null
              , mkNode $ String "foo"
              ]
            , mkNode $ Integer 5
            , mkNode $ List
              [ mkNode $ String "bar"
              , mkNode $ Bytes "\0\0"
              , mkNode $ Integer 6
              ]
            ]
          , _nSelected = True
          }
        )
      , ( "foo"
        , mkNode $ List
          [ mkNode $ Boolean False
          , mkNode $ Float 13.5
          , mkNode Null
          , mkNode $ Map
            [ ( "baz"
              , mkNode $ Integer 2
              )
            , ( "qux"
              , mkNode $ Boolean False
              )
            ]
          ]
        )
      ]
    }
