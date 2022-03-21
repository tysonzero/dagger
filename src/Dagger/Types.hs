{-# LANGUAGE TemplateHaskell #-}

module Dagger.Types
    ( State(..)
    , sDag
    , Node(..)
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

data Node
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

data Action
    = Modify (State -> State)
    | NoOp

initial :: State
initial = State
    { _sDag = Null
    }
