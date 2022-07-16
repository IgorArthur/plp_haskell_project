module DB where

import qualified System.IO.Strict as SIO

import Employee
import Customer
import TypeClasses
import Utils
import Servico

type Interaction = (DB -> Int -> IO ())

data DB = DB {
  employees :: [Employee],
  customers :: [Customer],
  servicos :: [Servico],
  currentIdEmployee :: Int,
  currentIdCustomer :: Int,
  currentIdServico :: Int
} deriving (Show)

listOfStringToListOfEmployees l = map read l :: [Employee]
listOfStringToListOfCustomers l = map read l :: [Customer]
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
  employeesContent <- readFile' "funcionario.txt"
  customersContent <- readFile' "cliente.txt"
  servicosContent <- readFile' "servico.txt"

  currentIdEmployeeContent <- readFile' "funcionarioId.txt"
  currentIdCustomerContent <- readFile' "clienteId.txt"
  currentIdServicoContent <- readFile' "servicoId.txt"

  let employees = listOfStringToListOfEmployees $ splitForFile $ employeesContent
  let customers = listOfStringToListOfCustomers $ splitForFile $ customersContent
  let servicos = listOfStringToListOfServicos $ splitForFile $ servicosContent

  let currentIdEmployee = stringToInt currentIdEmployeeContent
  let currentIdCustomer = stringToInt currentIdCustomerContent
  let currentIdServico = stringToInt currentIdServicoContent

  return (DB employees customers servicos currentIdEmployee currentIdCustomer currentIdServico) 
