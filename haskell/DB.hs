module DB where

import qualified System.IO.Strict as SIO

import Mechan

type Interaction = (DB -> Int -> IO ())

data DB = DB {
  mechan :: [Mechan]
} deriving (Show)

listOfStringToListOfMechan l = map read l :: [Mechan]

stringToInt str = read str :: Int

addToFile :: Stringfy a => FilePath -> a -> IO ()
addToFile path content = appendFile ("./db/" ++ path) (toString content ++ "\n")

writeToFile :: Stringfy a => FilePath -> [a] -> IO ()
writeToFile path content = writeFile ("./db/" ++ path) (listOfAnythingToString content)

writeIdToFile path id = writeFile ("./db/" ++ path) (show id)

readFile' path = SIO.readFile $ "./db/" ++ path

entityToFile :: (Entity a, Stringfy a) => a -> String -> String -> IO ()
entityToFile a entityFile idFile = do
  addToFile entityFile a
  writeIdToFile idFile (entityId a)
  return ()

connect :: IO DB
connect = do
  mechanContent <- readFile' "mechan.text"

  currentIdEmployeeContent <- readFile' "mechanId.txt"

  let mechan = listOfStringToListOfMechan $ splitForFile $ mechanContent

  let currentIdMechan = stringToInt currentIdMechanContent

  return (DB mechan) 
