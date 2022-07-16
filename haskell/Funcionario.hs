module Funcionario where

import TypeClasses

import Data.List.Split

type FuncionarioID = Int
type Ssn = String
type Name = String
type Role = String

data Funcionario = Funcionario {
  id :: FuncionarioID,
  ssn :: Ssn,
  name :: Name,
  role :: Role
} 

instance Person Funcionario where
  personSSN funcionario = Funcionario.ssn funcionario

instance Entity Funcionario where
  entityId funcionario = Funcionario.id funcionario

instance Show Funcionario where
  show (Funcionario id ssn name role) = "\n-----------------------\n" ++
                                                "ID: " ++ (show id) ++ "\n" ++
                                                "CPF: " ++ ssn ++ "\n" ++
                                                "Nome: " ++ name ++ "\n" ++
                                                "Função: " ++ role ++ "\n" ++
                                                "\n-----------------------\n"

instance Stringfy Funcionario where
  toString (Funcionario id ssn name role) = show id ++ "," ++
                                                    ssn ++ "," ++
                                                    name ++ "," ++
                                                    role

instance Read Funcionario where
  readsPrec _ str = do
  let l = splitOn "," str
  let id = read (l !! 0) :: FuncionarioID
  let ssn = l !! 1
  let name = l !! 2
  let role = l !! 3
  [(Funcionario id ssn name role, "")]