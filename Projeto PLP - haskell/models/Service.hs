module Serviço where

type Id = Int
type NomeCliente = String
type Contato = String
type ModeloVeiculo = String
type PlacaVeiculo = String

data Serviço = Serviço
  { cod :: Id,
    nome :: NomeCliente,
    contato :: Contato,
    modelo :: ModeloVeiculo,
    placa :: PlacaVeiculo
  }
  deriving (Read, Show)


criarServiço :: Id -> NomeCliente -> Contato -> ModeloVeiculo -> PlacaVeiculo -> IO()
criarServiço id nome contato modelo placa = do
  let serviço = Serviço {cod = id, nome = nome, contato = contato, modelo = modelo, placa = placa}
  file <- appendFile "serviços.txt" ("\n" ++ show serviço)
  putStrLn "Serviço cadastrado com sucesso!"


main :: IO ()
main = do
  nome <- getLine
  contato <- getLine
  modelo <- getLine
  placa <- getLine
  criarServiço 1 nome contato modelo placa
