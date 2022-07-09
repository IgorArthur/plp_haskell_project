module Utils where

import System.IO
import qualified System.Process as SP

clearScreen :: IO ()
clearScreen = do
  _ <- SP.system "clear"
  return ()

getString :: String -> IO String
getString text = do
    putStr text
    hFlush stdout
    getLine
