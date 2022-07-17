module FuncionarioInteraction where

import DB
import Cliente
import Utils

import Funcionario

registerCliente :: DB -> Interaction -> Int -> IO ()
registerCliente db funcionarioInteraction funcionarioId = do
  let clientes = DB.clientes db
  let funcionarios = DB.funcionarios db

  let clienteId = (DB.currentIdCliente db) + 1

  ssn <- input "CPF: "
  if existsPerson clientes ssn then do
    putStr "CPF já cadastrado.\n"
    registerCliente db funcionarioInteraction funcionarioId
  else if existsPerson funcionarios ssn then do
    let funcionario = getEntityById funcionarios funcionarioId
    let funcionarioSsn = Funcionario.ssn funcionario
    let funcionarioName = Funcionario.name funcionario
    address <- input $ funcionarioName ++ ", informe seu endereço: "

    let cliente = (Cliente clienteId funcionarioSsn  funcionarioName address)

    saveCliente db funcionarioInteraction funcionarioId clienteId cliente clientes

  else do
    name <- input "Nome: "
    address <- input "Endereço: "

    let cliente = (Cliente clienteId ssn name address)

    saveCliente db funcionarioInteraction funcionarioId clienteId cliente clientes

saveCliente :: DB -> Interaction -> Int -> Int -> Cliente -> [Cliente] -> IO()
saveCliente db funcionarioInteraction funcionarioId clienteId cliente clientes = do
  DB.entityToFile cliente "cliente.txt" "clienteId.txt"
  let newDB = db {DB.clientes = clientes ++ [cliente], DB.currentIdCliente = clienteId}

  clear
  putStr "Cliente cadastrado com sucesso!"
  putStr $ show cliente
  waitThreeSeconds
  funcionarioInteraction newDB funcionarioId