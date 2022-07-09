
import Admin
import Mechan
import Client
import Chat
import Utils

import AdminController

main = do
  start

start ::IO()
start = do
  putStr menu
    
  option <- getString "Opção: "

  let opc = read option

  if opc == 1 then do 
    clearScreen
    opcA <- getString "Digite seu id: "
    adminInteraction (read opcA)
  else if opc == 2 then do
    clearScreen
    putStr mechanOptions
    -- opcM <- getLine
    -- mechanInteracion (read opcM)
  else if opc == 3 then do
    clearScreen
    opcC <- getString "Digite seu id: "
    clientInteraction (read opcC)
    
  else if opc == 4 then do
    putStr "\nVolte sempre!\n"
  else
    putStr "\nOpção Inválida\n"

adminInteraction::Int -> IO()
adminInteraction idAdmin = do

  clearScreen
  putStr adminOptions
  op <- getString "Operaçao: "
  let opcAdmin = read op

  if opcAdmin == 1 then do
    registerMechanic idAdmin adminInteraction
  else if opcAdmin == 2 then do
    registerClient idAdmin adminInteraction
  else if opcAdmin == 3 then do
    start
  else if opcAdmin == 4 then do
    registerService idAdmin adminInteraction
  else
    start

-- Igor: - Me diga com quem tu andas que te digo quem tu és.

-- David: - Com que tu andas.

-- Igor: - Quem tu és.



clientInteraction::Int -> IO()
clientInteraction idClient = do

  putStr clientOptions
  op <- getLine
  let opcClient = read op

  if opcClient == 1 then do
    start
  else
    start

--mechanInteracion::Int -> IO()
--mechanInteracion opcMechan = do
