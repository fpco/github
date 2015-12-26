{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
module Github.Data.Name where

import Control.DeepSeq   (NFData(..))
import Data.Aeson.Compat (FromJSON(..), ToJSON(..))
import Data.Data         (Data, Typeable)
import Data.Hashable     (Hashable)
import Data.String       (IsString(..))
import GHC.Generics      (Generic)

newtype Name entity = N String
    deriving (Eq, Ord, Show, Read, Generic, Typeable, Data)

untagName :: Name entity -> String
untagName (N name) = name

instance Hashable (Name entity)

instance NFData (Name entity) where
    rnf (N s) = rnf s

instance FromJSON (Name entity) where
    parseJSON = fmap N . parseJSON

instance ToJSON (Name entity) where
    toJSON = toJSON . untagName

instance IsString (Name entity) where
    fromString = N
