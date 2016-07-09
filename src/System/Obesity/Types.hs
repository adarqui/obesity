{-# LANGUAGE DeriveGeneric #-}

module System.Obesity.Types (
  Options (..)
) where



import           Data.Text     (Text)
import           Data.Typeable (Typeable)
import           GHC.Generics  (Generic)
import Options.Generic



data Options = Options {
  optNumTypes        :: Int,
  optSeparateModules :: Bool,
  optExplicitImports :: Bool,
  optExplicitExports :: Bool
} deriving (Show, Read, Eq, Generic, Typeable)



instance ParseRecord Options
