module Employee where

import TypeClasses

import Data.List.Split

type EmployeeID = Int
type Ssn = String
type Name = String
type Role = String

data Employee = Employee {
  id :: EmployeeID,
  ssn :: Ssn,
  name :: Name,
  role :: Role
} 

instance Person Employee where
  personSSN employee = Employee.ssn employee

instance Entity Employee where
  entityId employee = Employee.id employee

instance Show Employee where
  show (Employee id ssn name role) = "\n-----------------------\n" ++
                                                "ID: " ++ (show id) ++ "\n" ++
                                                "CPF: " ++ ssn ++ "\n" ++
                                                "Nome: " ++ name ++ "\n" ++
                                                "Função: " ++ role ++ "\n" ++
                                                "\n-----------------------\n"

instance Stringfy Employee where
  toString (Employee id ssn name role) = show id ++ "," ++
                                                    ssn ++ "," ++
                                                    name ++ "," ++
                                                    role

instance Read Employee where
  readsPrec _ str = do
  let l = splitOn "," str
  let id = read (l !! 0) :: EmployeeID
  let ssn = l !! 1
  let name = l !! 2
  let role = l !! 3
  [(Employee id ssn name role, "")]