module Servico where

import Prelude hiding (id)

import TypeClasses

import Data.List.Split

type ServicoID = Int
type ClienteID = Int
type ModeloVeiculo = String
type PlacaVeiculo = String
type MecanicoID = Int
type Status = String
type ValorTotal = Float


data Servico = Servico { 
    cod :: ServicoID,
    clienteID :: ClienteID,
    modelo :: ModeloVeiculo,
    placa :: PlacaVeiculo,
    mecanicoID :: MecanicoID,
    status :: Status,
    valorTotal :: ValorTotal
  }

instance Entity Servico where
  entityId servico = Servico.cod servico

instance Item Servico where
  itemPrice servico = Servico.valorTotal servico

instance Show Servico where
   show (Servico cod clienteID modelo placa mecanicoID status valorTotal) = "\n-----------------------\n" ++
                                              "ID: " ++ show cod ++ "\n" ++
                                              "ID do Cliente: " ++ show clienteID ++ "\n" ++
                                              "Modelo do veículo: " ++ modelo ++ "\n" ++
                                              "Placa do veículo: " ++ placa ++ "\n" ++
                                              "ID do mecânico responsável pelo serviço: " ++ show mecanicoID ++ "\n" ++
                                              "Status do serviço: " ++ status ++ "\n" ++ 
                                              "Valor total: " ++ show valorTotal ++ 
                                              "\n-----------------------\n"

instance Stringfy Servico where
  toString (Servico cod clienteID modelo placa mecanicoID status valorTotal) = show cod ++ "," ++
                                                  show clienteID ++ "," ++
                                                  modelo ++ "," ++
                                                  placa ++ "," ++
                                                  show mecanicoID ++ "," ++
                                                  status ++ "," ++
                                                  show valorTotal

instance Read Servico where
  readsPrec _ str = do
  let l = splitOn "," str
  let cod = read (l !! 0) :: ServicoID
  let clienteID = read (l !! 1) :: ClienteID
  let modelo = l !! 2
  let placa = l !! 3
  let mecanicoID = read (l !! 4) :: MecanicoID
  let status = l !! 5
  let valorTotal = read (l !! 6) :: ValorTotal
  [(Servico cod clienteID modelo placa mecanicoID status valorTotal, "")]