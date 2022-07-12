module Database where

import qualified System.IO.Strict as SIO

import Utils
import Cliente
import TypeClasses

-- type Interaction = (DB -> Int -> IO ())

data Database = Database {
  clientes :: [Cliente],
  clienteID :: Int
} deriving (Show)

listOfStringToListOfClientes l = map read l :: [Cliente]
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

connect :: IO Database
connect = do
  clientesContent <- readFile' "cliente.txt"

  currentIdClienteContent <- readFile' "cId.txt"

  let clientes = listOfStringToListOfClientes $ splitForFile $ clientesContent

  let currentIdCliente = stringToInt currentIdClienteContent

  return (Database clientes currentIdCliente) 