module Mechan where

type Id = Int
type NomeMecanico = String
type ContatoMecanico = String

data Mecanico = Mecanico
  { cod :: Id,
    nome :: NomeMecanico,
    contato :: ContatoMecanico
  }
  deriving (Read, Show)


criarMecanico :: Id -> NomeMecanico -> ContatoMecanico -> IO()
criarMecanico cod nome contato = do
  let mecanico = Mecanico {cod = cod, nome = nome, contato = contato}
  file <- appendFile "db/mechan.txt" ("\n" ++ show mecanico)
  putStrLn "Mecânico cadastrado com sucesso!"

