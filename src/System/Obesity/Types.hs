{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}

module System.Obesity.Types (
  Options (..),
  defaultOptions,
  Lang (..)
) where



import           Data.Monoid                 ((<>))
import           Data.Text                   (Text)
import qualified Data.Text                   as T (unpack)
import           Data.Typeable               (Typeable)
import           GHC.Generics                (Generic)
import qualified Options.Applicative         as OptA (ParseError (..), argument,
                                                      help, long, metavar,
                                                      readerAbort, switch)
import qualified Options.Applicative.Builder as OptA (ReadM)
import qualified Options.Applicative.Types   as OptA (readerAsk)
import           Options.Generic
import           Text.Read                   (Read, readMaybe)



data Options = Options {
  separateModules :: Bool         <?> "create types in separate files or the same file",
  explicitImports :: Bool         <?> "be explicit about imports",
  explicitExports :: Bool         <?> "be explicit about exports",
  randomNumTypes  :: Bool         <?> "randomly generate types from 1 to numTypes",
  randomNumFields :: Bool         <?> "randomly generate fields within types, from 1 to numFields",
  numTypes        :: (Maybe Int)  <?> "number of types to create",
  numFields       :: (Maybe Int)  <?> "number of fields per type",
  lang            :: Lang         <?> "language to generate",
  dir             :: Text         <?> "directory to save files into"
} deriving (Show, Generic, Typeable)

instance ParseRecord Options



defaultOptions :: Options
defaultOptions = Options {
  separateModules = Helpful False,
  explicitImports = Helpful False,
  explicitExports = Helpful False,
  randomNumTypes  = Helpful False,
  randomNumFields = Helpful False,
  numTypes        = Helpful (Just 2),
  numFields       = Helpful (Just 10),
  lang            = Helpful (Lang_Haskell),
  dir             = Helpful "/tmp/"
}



data Lang
  = Lang_Haskell
  | Lang_Purescript
  | Lang_Golang
  deriving (Enum, Generic, Typeable)

instance Show Lang where
  show Lang_Haskell    = "haskell"
  show Lang_Purescript = "purescript"
  show Lang_Golang     = "golang"

instance Read Lang where
  readsPrec _ "haskell"    = [(Lang_Haskell, "")]
  readsPrec _ "purescript" = [(Lang_Purescript, "")]
  readsPrec _ "golang"     = [(Lang_Golang, "")]
  readsPrec _ _            = error "Language not supported"

instance ParseRecord Lang

instance ParseFields Lang where
  parseFields h m = do
    case m of
      Nothing   -> do
        let fs =  OptA.metavar "LANG"
               <> maybe mempty (OptA.help . T.unpack) h
        OptA.argument auto fs
      Just name -> pure Lang_Haskell



auto :: Read a => OptA.ReadM a
auto = do
  s <- OptA.readerAsk
  case readMaybe s of
    Just x  -> return x
    Nothing -> OptA.readerAbort OptA.ShowHelpText
