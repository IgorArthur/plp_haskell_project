module Servico where

import Cliente
import Mecanico

type ServicoID = Int
type Cliente = Cliente
type ModeloVeiculo = String
type PlacaVeiculo = String
type Mecanico = Mecanico
type Status = String

data Servico = Servico { 
    cod :: ServicoID,
    clienteID :: ClienteID,
    modelo :: ModeloVeiculo,
    placa :: PlacaVeiculo,
    mecanicoID :: FuncionarioID
    status :: Status
  }

instance Entity Servico where
  entityId servico = Servico.cod servico

instance Show Servico where
   show (Servico cod clienteID modelo placa mecanicoID status) = "\n-----------------------\n" ++
                                              "ID: " ++ (show cod) ++ "\n" ++
                                              "ID do Cliente: " ++ clienteID ++ "\n" ++
                                              "Modelo do veículo: " ++ modelo ++ "\n" ++
                                              "Placa do veículo: " ++ placa ++ "\n" ++
                                              "ID do mecânico responsável pelo serviço: " ++ mecanicoID ++ "\n" ++
                                              "Status do serviço: " ++ status ++ 
                                              "\n-----------------------\n"

instance Stringfy Servico where
  toString (Servico cod clienteID modelo placa mecanicoID status) = show cod ++ "," ++
                                                  cliente ++ "," ++
                                                  modelo ++ "," ++
                                                  placa ++ "," ++
                                                  mecanicoID ++ "," ++
                                                  status

instance Read Cliente where
  readsPrec _ str = do
  let l = splitOn "," str
  let cod = read (l !! 0) :: ServicoID
  let clienteID = read (l !! 1) :: ClienteID
  let modelo = l !! 2
  let placa = l !! 3
  let mecanicoID = read (l !! 4) :: FuncionarioID
  let status = l !! 5
  [(Cliente cod clienteID modelo placa mecanicoID status, "")]