{-# LANGUAGE OverloadedStrings #-}

module Main where

import Control.Concurrent (threadDelay)
import Control.Monad (forever)
import Data.String (fromString)
import System.Environment (getArgs)
import System.FSNotify
import qualified Turtle as T

main :: IO ()
main =
  withManager $ \mgr -> do
    [root, command] <- getArgs
    watchDir mgr root isAdded (execute $ fromString command)

    putStrLn "Started watching... Press Ctrl+C to terminate."
    forever $ threadDelay 1000000
  where
    isAdded (Added _ _) = True
    isAdded _           = False

    execute what (Added p _) =
      T.shell what T.empty >> return ()
    execute _ _ = return ()
  

-- vim: ts=2 sw=2
