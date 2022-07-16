module ServicoMenu (
  addServico,
  deleteServico,
) where

import Servico

addServico :: Servico -> [Servico] -> [Servico]
addServico servico servicos = servicos ++ [servico]

deleteServico :: Int -> [Servico] -> [Servico]
deleteServico id servicos = [c | c <- servicos, (Servico.cod c) /= id]

