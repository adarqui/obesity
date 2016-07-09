{-# LANGUAGE OverloadedStrings #-}

module Module.Main (
  main
) where



import           Options.Generic
import           System.Obesity.Types



main :: IO ()
main = do
  rec <- getRecord "Obesity"
  print (rec :: Options)
