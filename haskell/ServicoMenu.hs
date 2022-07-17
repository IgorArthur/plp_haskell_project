module ServicoMenu (
  addServico,
  deleteServico,
  setStatus,
) where

import Servico

addServico :: Servico -> [Servico] -> [Servico]
addServico servico servicos = servicos ++ [servico]

deleteServico :: Int -> [Servico] -> [Servico]
deleteServico id servicos = [c | c <- servicos, (Servico.cod c) /= id]

setStatus :: Int-> String
setStatus option 
  | option == 1 = "EM ESPERA"
  | option == 2 = "INICIADO"
  | option == 3 = "EM PAUSA"
  | option == 4 = "VEÍCULO EM TESTES"
  | option == 5 = "ENCERRADO"
