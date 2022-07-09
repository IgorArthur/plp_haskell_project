import Admin
import Mechan
import Client
import Chat
import Utils

main = do
  start

start ::IO()
start = do
  putStr menu
    
  option <- getLine

  let opc = read option

  if opc == 1 then do 
    clearScreen
    opcA <- getString "Digite seu id:"
    adminInteraction (read opcA)
  else if opc == 2 then do
    clearScreen
    putStr mechanOptions
    -- opcM <- getLine
    -- mechanInteracion (read opcM)
  else if opc == 3 then do
    clearScreen
    opcC <- getString "Digite seu id:"
    clientInteraction (read opcC)
    
  else if opc == 4 then do
    putStr "\nAdeus!\n"
  else
    putStr "\nOpção Inválida\n"

adminInteraction::Int -> IO()
adminInteraction idAdmin = do

  putStr adminOptions
  op <- getLine
  let opcAdmin = read op

  if opcAdmin == 1 then do
    idMecanico <- getString "Digite o Id do mecânico:"
    nomeMecanico <- getString "Digite o nome do mecânico:" 
    contatoMecanico <- getString "Digite o contato do mecânico:"
    criarMecanico (read idMecanico) nomeMecanico contatoMecanico
  else if opcAdmin == 2 then do
    idClient <- getString "Digite o Id do cliente:"
    nomeCliente <- getString "Digite o nome do mecânico:" 
    contatoCliente <- getString "Digite o contato do cliente:"
    criarCliente 1 nomeCliente contatoCliente
  else
    start

clientInteraction::Int -> IO()
clientInteraction idClient = do

  putStr clientOptions
  op <- getLine
  let opcClient = read op

  if opcClient == 1 then do
    statusServico <- getString "Qual serviço deseja vê o status:"
    start
  else
    start

-- mechanInteracion::Int -> IO()
-- mechanInteracion opcMechan = do
