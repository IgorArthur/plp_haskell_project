import CustomerInteraction
import OwnerInteraction
import EmployeeInteraction
import Chat
import DB
import Utils
import EmployeeController
import System.Exit

import Prelude hiding (id)

main = do
  dados <- DB.connect
  start dados

start :: DB -> IO()
start db = do
  clear 
  putStr slogan
  putStr options

  option <- input "Número: "

  let number = read option

  if number == 1 then do
    clear
    oId <- input "Digite o seu ID: "
    ownerInteraction db (read oId)
  else if number == 2 then do
    clear
    fId <- input "Digite o seu ID: "
    clear
    employeeInteraction db (read fId) 
  else if number == 3 then do
    clear
    cId <- input "Digite o seu ID: "
    clear
    customerInteraction db (read cId)
  else if number == 4 then do
    die "\nVolte sempre!\n"
  else
    start db

ownerInteraction :: DB -> Int -> IO ()
ownerInteraction db ownerId = do
  clear
  let employees = DB.employees db
  if not $ existsOwner employees then do
    putStr "Administrador não cadastrado.\n"
    op <- input "\nGostaria de cadastrar um administrador?\n[S - SIM ou qualquer letra para NÃO]: "
    if head op `elem` "Ss" then do
      registerOwner db start
    else do
      start db
  else do
    if not $ hasPermission ownerId employees "Administrador" then do
      putStr "O ID informado não pertence a um administrador.\n"
      waitThreeSeconds
      start db
    else do
      clear
      putStr ownerOptions

      option <- input "Número: "

      let number = read option

      if number == 1 then do
        registerEmployee db ownerInteraction ownerId
      else if number == 2 then do
        registerCustomer db ownerInteraction ownerId
      else if number == 3 then do
        registerServico db ownerInteraction ownerId
      else if number == 4 then do
        removeServico db ownerInteraction ownerId
      else if number == 5 then do
        start db
      else do
        ownerInteraction db ownerId

customerInteraction :: DB -> Int -> IO ()
customerInteraction db customerId = do
  let customers = DB.customers db

  if not $ existsEntity customers customerId then do
    putStr "Não há um cliente com esse id.\n"
    waitTwoSeconds
    clear
    start db
  else do
    clear
    putStr customerOptions

    option <- input "Número: "
    let num = read option

    if num == 1 then do
      clear
      let list = showCustomerServices (DB.servicos db) customerId
      if not $ null list then do
        displayList list customerInteraction db customerId
      else do
        putStr "Você não possui servicos pendentes.\n"
        waitThreeSeconds
        customerInteraction db customerId
    else if num == 2 then do
      clear
      continue
      clear
      customerInteraction db customerId
    else if num == 3 then do
      start db
    else do
      customerInteraction db customerId

employeeInteraction :: DB -> Int -> IO()
employeeInteraction db employeeId = do
  let employees = DB.employees db 

  if not $ existsEntity employees employeeId then do
    putStr "Mecânico inexistente...\n"
    waitTwoSeconds
    clear
    start db
  else if not $ hasPermission employeeId employees "Mecânico" then do
    putStr "O ID informado não pertence a um mecânico.\n"
    waitTwoSeconds
    clear
    start db
  else do
    clear
    putStr employeeOptions

    option <- input "Número: "
    let num = read option

    if num == 1 then do
      registerServico db employeeInteraction employeeId
    else if num == 2 then do
      clear
      registerCustomer db employeeInteraction employeeId
    else if num == 3 then do
      start db
    else do
      employeeInteraction db employeeId
