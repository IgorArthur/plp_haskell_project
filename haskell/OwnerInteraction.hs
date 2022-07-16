module OwnerInteraction where

import DB
import Utils
import Employee
import Servico
import Customer
import ServicoMenu

getCredentials :: [Employee] -> IO [String]
getCredentials employees = do
  ssn <- input "CPF: "
  if existsPerson employees ssn then do
    putStr "CPF já cadastrado.\n"
    waitTwoSeconds
    getCredentials employees
  else do
    name <- input "Nome: "
    return [ssn,name]

registerOwner :: DB -> (DB -> IO()) -> IO ()
registerOwner db start = do
  let employees = DB.employees db

  let employeeId = (DB.currentIdEmployee db) + 1

  [ssn, name] <- getCredentials employees
  let role = "Administrador"

  if existsPerson employees ssn then do
    putStr "CPF já cadastrado.\n"
    waitTwoSeconds
    start db
  else do
    let employee = (Employee employeeId ssn name role)

    DB.entityToFile employee "funcionario.txt" "funcionarioId.txt"
    let newDB = db {DB.employees = employees ++ [employee], DB.currentIdEmployee = employeeId}
    
    clear
    putStr "Administrador cadastrado com sucesso!"
    putStr $ show employee
    waitThreeSeconds

    start newDB

registerEmployee :: DB -> Interaction -> Int -> IO ()
registerEmployee db ownerInteraction ownerId = do
  let employees = DB.employees db

  let employeeId = (DB.currentIdEmployee db) + 1

  [ssn, name] <- getCredentials employees
  
  let role = "Mecânico" 
  let employee = (Employee employeeId ssn name role)

  DB.entityToFile employee "funcionario.txt" "funcionarioId.txt"
  let newDB = db {DB.employees = employees ++ [employee], DB.currentIdEmployee = employeeId}
  
  clear
  putStr "Mecânico cadastrado com sucesso!"
  putStr $ show employee
  waitThreeSeconds

  ownerInteraction newDB ownerId

-- SERVICO

registerServico :: DB -> Interaction -> Int -> IO ()
registerServico db ownerInteraction ownerId = do
  let servicos = (DB.servicos db)
  let clientes = (DB.customers db)
  let funcionarios = (DB.employees db)
  let servicoId = (DB.currentIdServico db) + 1

  clienteID <- input "ID do cliente: "
  if not $ existsEntity clientes (read clienteID) then do
    putStr "Não há um cliente com esse ID.\n"
    waitTwoSeconds
    clear
    ownerInteraction db ownerId

  else do 
    modelo <- input "Modelo do veículo: "
    placa <- input "Placa do veículo: "
    mecanicoID <- input "ID do mecânico: "

    if not $ existsEntity funcionarios (read mecanicoID) then do

      putStr "Mecânico inexistente...\n"
      waitTwoSeconds
      clear
      ownerInteraction db ownerId

    else do 
      status <- input "Status do serviço: "
      valorTotal <- input "Valor do serviço: "

      let servico = (Servico servicoId (read clienteID) modelo placa (read mecanicoID) status (read valorTotal))

      DB.entityToFile servico "servico.txt" "servicoId.txt"
      let newDB = db {DB.servicos = addServico servico servicos, DB.currentIdServico = servicoId}
      
      clear
      putStr "Servico cadastrado com sucesso!"
      putStr $ show servico
      waitThreeSeconds

      ownerInteraction newDB ownerId

deleteService :: Int -> [Servico] -> [Servico]
deleteService id servicos = [c | c <- servicos, (Servico.cod c) /= id]

removeServico :: DB -> Interaction -> Int -> IO ()
removeServico db ownerInteraction ownerId = do
  let servicos = (DB.servicos db)
  let clientes = (DB.customers db)
  let funcionarios = (DB.employees db)

  serviceID <- input "ID do serviço a ser excluído: "
  if not $ existsEntity servicos (read serviceID) then do
    putStr "Não há um serviço com esse ID.\n"
    waitTwoSeconds
    clear
    ownerInteraction db ownerId

  else do 
    -- modelo <- input "Novo modelo do veículo: "
    -- placa <- input "Nova placa do veículo: "
    -- mecanicoID <- input "Novo ID do mecânico: "

    -- if not $ existsEntity funcionarios (read mecanicoID) then do

    --   putStr "Mecânico inexistente...\n"
    --   waitTwoSeconds
    --   clear
    --   ownerInteraction db ownerId

    -- else do 
      -- status <- input "Novo status do serviço: "
      -- valorTotal <- input "Novo valor do serviço: "

      -- let servico = (Servico serviceID (read clienteID) modelo placa (read mecanicoID) status (read valorTotal))

    --print $ getEntityById servicos (read serviceID) 
    let newServiceList = deleteService (read serviceID) servicos
    putStr "Serviço removido com sucesso.\n"
    waitThreeSeconds
    DB.writeToFile "servico.txt" newServiceList
  
    let newDB = db {DB.servicos = newServiceList}
    ownerInteraction newDB ownerId
  
      -- else do
      --   print $ getEntityById drinks (read drinkId) 
      --   let newDrinkList = deleteDrink (read drinkId) drinks
      --   putStr "Bebida removida com sucesso.\n"
      --   waitThreeSeconds
      --   DB.writeToFile "bebida.txt" newDrinkList
  
      --   let newDB = db {DB.drinks = newDrinkList}
      --   ownerInteraction newDB ownerId

    -- let newDB = db {DB.drinks = newDrinkList}

    --   DB.entityToFile servico "servico.txt" "servicoId.txt"
    --   let newDB = db {DB.servicos = addServico servico servicos, DB.currentIdServico = servicoId}
      
    --   clear
    --   putStr "Servico cadastrado com sucesso!"
    --   putStr $ show servico
    --   waitThreeSeconds

    --   ownerInteraction newDB ownerId

-- DRINKS
