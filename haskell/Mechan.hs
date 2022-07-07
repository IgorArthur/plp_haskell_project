module Mechan where

type Id = Int
type NomeMecanico = String

data Mecanico = Mecanico
  { cod :: Id,
    nome :: NomeMecanico
  }
  deriving (Read, Show)


criarMecanico :: Id -> NomeMecanico -> IO()
criarMecanico cod nome = do
  let mecanico = Mecanico {cod = cod, nome = nome}
  file <- appendFile "db/mechan.txt" ("\n" ++ show mecanico)
  putStrLn "Mecânico cadastrado com sucesso!"

