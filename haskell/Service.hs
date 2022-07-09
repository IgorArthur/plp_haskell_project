module Service where

type Id = Int
type NomeCliente = String
type Contato = String
type ModeloVeiculo = String
type PlacaVeiculo = String
type IdMecanico = Int

data Service = Service
  { cod :: Id,
    nome :: NomeCliente,
    contato :: Contato,
    modelo :: ModeloVeiculo,
    placa :: PlacaVeiculo,
    codMecanico :: IdMecanico
  }
  deriving (Read, Show)


criarServiço :: Id -> NomeCliente -> Contato -> ModeloVeiculo -> PlacaVeiculo -> IdMecanico -> IO()
criarServiço id nome contato modelo placa codMecanico = do
  let serviço = Service {cod = id, nome = nome, contato = contato, modelo = modelo, placa = placa, codMecanico = codMecanico}
  file <- appendFile "db/serviços.txt" ("\n" ++ show serviço)
  putStrLn "Serviço cadastrado com sucesso!"
