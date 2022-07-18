module FuncionarioController (
  hasPermission,
  existsAdmin
) where

import Prelude hiding (id)

import Funcionario

hasPermission :: Int -> [Funcionario] -> String -> Bool
hasPermission id funcionarios role = not $ null [e | e <- funcionarios, (Funcionario.id e) == id, (Funcionario.role e) == role]

existsAdmin :: [Funcionario] -> Bool
existsAdmin funcionarios =  not $ null [e | e <- funcionarios, (Funcionario.role e) == "Administrador"]