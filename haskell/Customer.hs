module Customer where

import TypeClasses

import Data.List.Split

type CustomerID = Int
type Ssn = String
type Name = String
type Address = String

data Customer = Customer {
  id :: CustomerID,
  ssn :: Ssn,
  name :: Name,
  address :: Address
}

instance Person Customer where
  personSSN customer = Customer.ssn customer

instance Entity Customer where
  entityId customer = Customer.id customer

instance Show Customer where
  show (Customer id ssn name address) = "\n-----------------------\n" ++
                                              "ID: " ++ (show id) ++ "\n" ++
                                              "CPF: " ++ ssn ++ "\n" ++
                                              "Nome: " ++ name ++ "\n" ++
                                              "Endereço: " ++ address ++
                                              "\n-----------------------\n"

instance Stringfy Customer where
  toString (Customer id ssn name address) = show id ++ "," ++
                                                  ssn ++ "," ++
                                                  name ++ "," ++
                                                  address

instance Read Customer where
  readsPrec _ str = do
  let l = splitOn "," str
  let id = read (l !! 0) :: CustomerID
  let ssn = l !! 1
  let name = l !! 2
  let address = l !! 3
  [(Customer id ssn name address, "")]