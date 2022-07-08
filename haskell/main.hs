import Admin
import Client
import Chat

main = do
  start

start ::IO()
start = do
  putStr menu
    
  option <- getLine

  let opc = read option

  if opc == 1 then do 
    putStr adminOptions
    opcA <- getLine
    adminInteraction (read opcA)
  else if opc == 2 then do
    putStr clientOptions
  else if opc == 3 then do
    putStr mechanOptions 
  else if opc == 4 then do
    putStr "\nAdeus!\n"
  else
    putStr "\nOpção Inválida\n"

adminInteraction ::Int -> IO()
adminInteraction opcAdmin = do

  if opcAdmin == 1 then do
    putStr "Digite o nome do mecânico:"
    nomeMecanico <- getLine
    putStr "Digite o contato do mecânico:"
    contatoMecanico <- getLine
    criarMecanico 1 (read nomeMecanico) (read contatoMecanico)
  else if opcAdmin == 2 then do
    putStr "Digite o nome do cliente:"
    nomeCliente <- getLine
    putStr "Digite o contato do mecânico:"
    contatoCliente <- getLine
    criarCliente 1 (read nomeCliente) (read contatoCliente)
  else
    start