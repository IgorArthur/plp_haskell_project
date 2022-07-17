module Cliente where

import TypeClasses

import Data.List.Split

type ClienteID = Int
type Ssn = String
type Name = String
type Address = String

data Cliente = Cliente {
  id :: ClienteID,
  ssn :: Ssn,
  name :: Name,
  address :: Address
}

instance Person Cliente where
  personSSN cliente = Cliente.ssn cliente

instance Entity Cliente where
  entityId cliente = Cliente.id cliente

instance Show Cliente where
  show (Cliente id ssn name address) = "\n-----------------------\n" ++
                                              "ID: " ++ (show id) ++ "\n" ++
                                              "CPF: " ++ ssn ++ "\n" ++
                                              "Nome: " ++ name ++ "\n" ++
                                              "Endereço: " ++ address ++
                                              "\n-----------------------\n"

instance Stringfy Cliente where
  toString (Cliente id ssn name address) = show id ++ "," ++
                                                  ssn ++ "," ++
                                                  name ++ "," ++
                                                  address

instance Read Cliente where
  readsPrec _ str = do
  let l = splitOn "," str
  let id = read (l !! 0) :: ClienteID
  let ssn = l !! 1
  let name = l !! 2
  let address = l !! 3
  [(Cliente id ssn name address, "")]