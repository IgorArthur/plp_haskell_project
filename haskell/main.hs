import ClienteInteraction
import AdminInteraction
import FuncionarioInteraction
import Chat
import DB
import Utils
import FuncionarioController
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
    adminInteraction db (read oId)
  else if number == 2 then do
    clear
    fId <- input "Digite o seu ID: "
    clear
    funcionarioInteraction db (read fId) 
  else if number == 3 then do
    clear
    cId <- input "Digite o seu ID: "
    clear
    clienteInteraction db (read cId)
  else if number == 4 then do
    die "\nVolte sempre!\n"
  else
    start db

adminInteraction :: DB -> Int -> IO ()
adminInteraction db adminId = do
  clear
  let funcionarios = DB.funcionarios db
  if not $ existsAdmin funcionarios then do
    putStr "Administrador não cadastrado.\n"
    op <- input "\nGostaria de cadastrar um administrador?\n[S - SIM ou qualquer letra para NÃO]: "
    if head op `elem` "Ss" then do
      registerAdmin db start
    else do
      start db
  else do
    if not $ hasPermission adminId funcionarios "Administrador" then do
      putStr "O ID informado não pertence a um administrador.\n"
      waitThreeSeconds
      start db
    else do
      clear
      putStr adminOptions

      option <- input "Número: "

      let number = read option

      if number == 1 then do
        registerFuncionario db adminInteraction adminId
      else if number == 2 then do
        clear
        displayEntity (DB.funcionarios db) ""
        voltar adminInteraction db adminId
      else if number == 3 then do
        registerCliente db adminInteraction adminId
      else if number == 4 then do
        registerServico db adminInteraction adminId
      else if number == 5 then do
        clear
        displayEntity (DB.servicos db) "servicos"
        voltar adminInteraction db adminId
      else if number == 6 then do
        removeServico db adminInteraction adminId
      else if number == 7 then do
        updateStatus db adminInteraction adminId
      else if number == 8 then do
        clear
        displayEntity (DB.clientes db) "clientes"
        voltar adminInteraction db adminId
      else if number == 9 then do
        start db
      else do
        adminInteraction db adminId

clienteInteraction :: DB -> Int -> IO ()
clienteInteraction db clienteId = do
  let clientes = DB.clientes db

  if not $ existsEntity clientes clienteId then do
    putStr "Não há um cliente com esse id.\n"
    waitTwoSeconds
    clear
    start db
  else do
    clear
    putStr clienteOptions

    option <- input "Número: "
    let num = read option

    if num == 1 then do
      clear
      let list = showClienteServices (DB.servicos db) clienteId
      if not $ null list then do
        displayList list clienteInteraction db clienteId
      else do
        putStr "Você não possui servicos pendentes.\n"
        waitThreeSeconds
        clienteInteraction db clienteId
    else if num == 2 then do
      clear
      continue
      clear
      clienteInteraction db clienteId
    else if num == 3 then do
      start db
    else do
      clienteInteraction db clienteId

funcionarioInteraction :: DB -> Int -> IO()
funcionarioInteraction db funcionarioId = do
  let funcionarios = DB.funcionarios db 

  if not $ existsEntity funcionarios funcionarioId then do
    putStr "Mecânico inexistente...\n"
    waitTwoSeconds
    clear
    start db
  else if not $ hasPermission funcionarioId funcionarios "Mecânico" then do
    putStr "O ID informado não pertence a um mecânico.\n"
    waitTwoSeconds
    clear
    start db
  else do
    clear
    putStr funcionarioOptions

    option <- input "Número: "
    let num = read option

    if num == 1 then do
      registerServico db funcionarioInteraction funcionarioId
    else if num == 2 then do
      clear
      registerCliente db funcionarioInteraction funcionarioId
    else if num == 3 then do
      clear
      displayEntity (DB.servicos db) "servicos"
      voltar funcionarioInteraction db funcionarioId
    else if num == 4 then do
      updateStatus db funcionarioInteraction funcionarioId
    else if num == 5 then do
      start db
    else do
      funcionarioInteraction db funcionarioId


voltar :: Interaction -> DB -> Int -> IO()
voltar interaction db id = do
  input "\nDigite algo para voltar: "
  interaction db id