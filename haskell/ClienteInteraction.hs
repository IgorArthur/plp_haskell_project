module ClienteInteraction where

import DB
import Utils
import Servico

backToClienteInteraction :: DB -> Interaction -> Int -> IO ()
backToClienteInteraction db clienteInteraction currentClienteId = do
  continue
  clear
  clienteInteraction db currentClienteId

showClienteServices :: [Servico] -> Int -> [Servico]
showClienteServices services custumerId = [e | e <- services, (Servico.clienteID e) == custumerId]

displayList :: [Servico] -> Interaction -> DB -> Int ->  IO ()
displayList list clienteInteraction db clienteId = do
  displayEntity list ""
  option2 <- input "\nDigite 1 para voltar: "
  let num2 = read option2
  if num2 == 1 then do
    clienteInteraction db clienteId
  else do
    clear
    displayList list clienteInteraction db clienteId
  
