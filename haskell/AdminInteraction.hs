module AdminInteraction where

import Data.Char
import Chat
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
      let status = "EM ESPERA"
      descricao <- input "Descrição do serviço: "
      valorTotal <- input "Valor do serviço: "

      let servico = (Servico servicoId (read clienteID) modelo placa (read mecanicoID) descricao status (read valorTotal))

      DB.entityToFile servico "servico.txt" "servicoId.txt"
      let newDB = db {DB.servicos = addServico servico servicos, DB.currentIdServico = servicoId}
      
      clear
      putStr "Servico cadastrado com sucesso!"
      putStr $ show servico
      waitThreeSeconds

      adminInteraction newDB adminId


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
    let newServiceList = deleteServico (read serviceID) servicos
    putStr "Serviço removido com sucesso.\n"
    waitThreeSeconds
    DB.writeToFile "servico.txt" newServiceList
  
    let newDB = db {DB.servicos = newServiceList}
    adminInteraction newDB adminId
  
     
-- STATUS

updateStatus :: DB -> Interaction -> Int -> IO ()
updateStatus db adminInteraction adminId = do
  clear
  let list = (DB.servicos db)
  --verifca se existe servicos
  if not $ null list then do
    displayEntity list ""

    option <- input "\nSelecione o id do servico: "

    -- Verifica se a entrada é um inteiro válido
    if (all isNumber option) == False then do  
      putStr "\nDigite uma entrada válida."
      updateStatus db adminInteraction adminId
    else do
      let servicoID = read option
      updateService db adminInteraction adminId servicoID

  else do
    putStr "Não há servicos cadastrados no momento.\n"
    waitThreeSeconds
    adminInteraction db adminId


updateService :: DB -> Interaction -> Int -> Int -> IO ()
updateService db adminInteraction adminId servicoID = do
  clear
  -- verifica se o ID existe
  if existsEntity (DB.servicos db) servicoID then do    
    let servico = getEntityById (DB.servicos db) servicoID

    putStr statusOptions

    entrada <- input "\nSelecione o status: "
    let option = read entrada

    if option `elem` [1..5] then do
      let status = setStatus option
      -- cria um novo servico com o novo status
      let modServico = (Servico (Servico.cod servico) (Servico.clienteID servico) (Servico.modelo servico) (Servico.placa servico) (Servico.mecanicoID servico) (Servico.descricao servico) status (Servico.valorTotal servico))

      -- Pega a lista de servicos menos o do ID selecionado, e adiciona o novo servico com o status atualizado
      let servicosAtuais = [s | s <- (DB.servicos db), (Servico.cod s) /= servicoID]
      let novosServicos = addServico modServico servicosAtuais

      -- escreve no arquivo a nova lista atualizada
      DB.writeToFile "servico.txt" novosServicos
      let newDB = db {DB.servicos = novosServicos}

      putStr "\nStatus Atualizado com sucesso!!\n"
      waitTwoSeconds
      adminInteraction newDB adminId    
    else do
      putStr "Status inválido"
      updateService db adminInteraction adminId servicoID
    

  else do
    putStr "\nID de servico não existe.\n"
    waitTwoSeconds
    adminInteraction db adminId


