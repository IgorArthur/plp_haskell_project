module Cliente where

import TypeClasses
import Data.List.Split

type ClienteID = Int
type Nome = String
type Contato = String

data Cliente = Cliente
  { cod :: ClienteID,
    nome :: Nome,
    contato :: Contato
  }

instance Entity Cliente where
  entityId cliente = Cliente.cod cliente

instance Show Cliente where
   show (Cliente cod nome contato) = "\n-----------------------\n" ++
                                              "ID: " ++ (show cod) ++ "\n" ++
                                              "Nome: " ++ nome ++ "\n" ++
                                              "Contato: " ++ contato ++ 
                                              "\n-----------------------\n"

instance Stringfy Cliente where
  toString (Cliente cod nome contato) = show cod ++ "," ++
                                                  nome ++ "," ++
                                                  contato 

instance Read Cliente where
  readsPrec _ str = do
  let l = splitOn "," str
  let cod = read (l !! 0) :: ClienteID
  let nome = l !! 1
  let contato = l !! 2
  [(Cliente cod nome contato, "")]