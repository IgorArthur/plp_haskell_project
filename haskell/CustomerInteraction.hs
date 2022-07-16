module CustomerInteraction where

import DB
import Utils
import Servico

backToCustomerInteraction :: DB -> Interaction -> Int -> IO ()
backToCustomerInteraction db customerInteraction currentCustomerId = do
  continue
  clear
  customerInteraction db currentCustomerId

showCustomerServices :: [Servico] -> Int -> [Servico]
showCustomerServices services custumerId = [e | e <- services, (Servico.clienteID e) == custumerId]

displayList :: [Servico] -> Interaction -> DB -> Int ->  IO ()
displayList list customerInteraction db customerId = do
  displayEntity list ""
  option2 <- input "\nDigite 1 para voltar: "
  let num2 = read option2
  if num2 == 1 then do
    customerInteraction db customerId
  else do
    clear
    displayList list customerInteraction db customerId
  
