{-# LANGUAGE DeriveGeneric #-}

module System.Obesity.Types (
  Options (..)
) where



import           Data.Text     (Text)
import           Data.Typeable (Typeable)
import           GHC.Generics  (Generic)



data Options = Options {
  optSeparateModules :: Bool,
  optExplicitImports :: Bool,
  optExplicitExports :: Bool
} deriving (Show, Read, Eq, Generic, Typeable)
