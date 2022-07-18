module DB where

import qualified System.IO.Strict as SIO

import Funcionario
import Cliente
import TypeClasses
import Utils
import Servico

type Interaction = (DB -> Int -> IO ())

data DB = DB {
  funcionarios :: [Funcionario],
  clientes :: [Cliente],
  servicos :: [Servico],
  currentIdFuncionario :: Int,
  currentIdCliente :: Int,
  currentIdServico :: Int
} deriving (Show)

listOfStringToListOfFuncionarios l = map read l :: [Funcionario]
listOfStringToListOfClientes l = map read l :: [Cliente]
listOfStringToListOfServicos l = map read l :: [Servico]
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
  funcionariosContent <- readFile' "funcionario.txt"
  clientesContent <- readFile' "cliente.txt"
  servicosContent <- readFile' "servico.txt"

  currentIdFuncionarioContent <- readFile' "funcionarioId.txt"
  currentIdClienteContent <- readFile' "clienteId.txt"
  currentIdServicoContent <- readFile' "servicoId.txt"

  let funcionarios = listOfStringToListOfFuncionarios $ splitForFile $ funcionariosContent
  let clientes = listOfStringToListOfClientes $ splitForFile $ clientesContent
  let servicos = listOfStringToListOfServicos $ splitForFile $ servicosContent

  let currentIdFuncionario = stringToInt currentIdFuncionarioContent
  let currentIdCliente = stringToInt currentIdClienteContent
  let currentIdServico = stringToInt currentIdServicoContent

  return (DB funcionarios clientes servicos currentIdFuncionario currentIdCliente currentIdServico) 
