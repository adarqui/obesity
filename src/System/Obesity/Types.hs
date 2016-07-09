{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}

module System.Obesity.Types (
  Options (..)
) where



import           Data.Text       (Text)
import           Data.Typeable   (Typeable)
import           GHC.Generics    (Generic)
import           Options.Generic



data Options = Options {
  numTypes        :: Int  <?> "number of types to create",
  separateModules :: Bool <?> "create types in separate files or the same file",
  explicitImports :: Bool <?> "be explicit about imports",
  explicitExports :: Bool <?> "be explicit about exports"
} deriving (Show, Generic, Typeable)



data Cli
  = Generate Options Text
  deriving (Show, Generic, Typeable)



instance ParseRecord Options
-- instance ParseRecord Cli
