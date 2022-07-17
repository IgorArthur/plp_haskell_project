module AdminInteraction where

import DB
import Utils
import Funcionario
import Servico
import Cliente
import ServicoMenu

getCredentials :: [Funcionario] -> IO [String]
getCredentials funcionarios = do
  ssn <- input "CPF: "
  if existsPerson funcionarios ssn then do
    putStr "CPF já cadastrado.\n"
    waitTwoSeconds
    getCredentials funcionarios
  else do
    name <- input "Nome: "
    return [ssn,name]

registerAdmin :: DB -> (DB -> IO()) -> IO ()
registerAdmin db start = do
  let funcionarios = DB.funcionarios db

  let funcionarioId = (DB.currentIdFuncionario db) + 1

  [ssn, name] <- getCredentials funcionarios
  let role = "Administrador"

  if existsPerson funcionarios ssn then do
    putStr "CPF já cadastrado.\n"
    waitTwoSeconds
    start db
  else do
    let funcionario = (Funcionario funcionarioId ssn name role)

    DB.entityToFile funcionario "funcionario.txt" "funcionarioId.txt"
    let newDB = db {DB.funcionarios = funcionarios ++ [funcionario], DB.currentIdFuncionario = funcionarioId}
    
    clear
    putStr "Administrador cadastrado com sucesso!"
    putStr $ show funcionario
    waitThreeSeconds

    start newDB

registerFuncionario :: DB -> Interaction -> Int -> IO ()
registerFuncionario db adminInteraction adminId = do
  let funcionarios = DB.funcionarios db

  let funcionarioId = (DB.currentIdFuncionario db) + 1

  [ssn, name] <- getCredentials funcionarios
  
  let role = "Mecânico" 
  let funcionario = (Funcionario funcionarioId ssn name role)

  DB.entityToFile funcionario "funcionario.txt" "funcionarioId.txt"
  let newDB = db {DB.funcionarios = funcionarios ++ [funcionario], DB.currentIdFuncionario = funcionarioId}
  
  clear
  putStr "Mecânico cadastrado com sucesso!"
  putStr $ show funcionario
  waitThreeSeconds

  adminInteraction newDB adminId

-- SERVICO

registerServico :: DB -> Interaction -> Int -> IO ()
registerServico db adminInteraction adminId = do
  let servicos = (DB.servicos db)
  let clientes = (DB.clientes db)
  let funcionarios = (DB.funcionarios db)
  let servicoId = (DB.currentIdServico db) + 1

  clienteID <- input "ID do cliente: "
  if not $ existsEntity clientes (read clienteID) then do
    putStr "Não há um cliente com esse ID.\n"
    waitTwoSeconds
    clear
    adminInteraction db adminId

  else do 
    modelo <- input "Modelo do veículo: "
    placa <- input "Placa do veículo: "
    mecanicoID <- input "ID do mecânico: "

    if not $ existsEntity funcionarios (read mecanicoID) then do

      putStr "Mecânico inexistente...\n"
      waitTwoSeconds
      clear
      adminInteraction db adminId

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

      adminInteraction newDB adminId

deleteService :: Int -> [Servico] -> [Servico]
deleteService id servicos = [c | c <- servicos, (Servico.cod c) /= id]

removeServico :: DB -> Interaction -> Int -> IO ()
removeServico db adminInteraction adminId = do
  let servicos = (DB.servicos db)
  let clientes = (DB.clientes db)
  let funcionarios = (DB.funcionarios db)

  serviceID <- input "ID do serviço a ser excluído: "
  if not $ existsEntity servicos (read serviceID) then do
    putStr "Não há um serviço com esse ID.\n"
    waitTwoSeconds
    clear
    adminInteraction db adminId

  else do 
    -- modelo <- input "Novo modelo do veículo: "
    -- placa <- input "Nova placa do veículo: "
    -- mecanicoID <- input "Novo ID do mecânico: "

    -- if not $ existsEntity funcionarios (read mecanicoID) then do

    --   putStr "Mecânico inexistente...\n"
    --   waitTwoSeconds
    --   clear
    --   adminInteraction db adminId

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
    adminInteraction newDB adminId
  
      -- else do
      --   print $ getEntityById drinks (read drinkId) 
      --   let newDrinkList = deleteDrink (read drinkId) drinks
      --   putStr "Bebida removida com sucesso.\n"
      --   waitThreeSeconds
      --   DB.writeToFile "bebida.txt" newDrinkList
  
      --   let newDB = db {DB.drinks = newDrinkList}
      --   adminInteraction newDB adminId

    -- let newDB = db {DB.drinks = newDrinkList}

    --   DB.entityToFile servico "servico.txt" "servicoId.txt"
    --   let newDB = db {DB.servicos = addServico servico servicos, DB.currentIdServico = servicoId}
      
    --   clear
    --   putStr "Servico cadastrado com sucesso!"
    --   putStr $ show servico
    --   waitThreeSeconds

    --   adminInteraction newDB adminId

-- DRINKS
