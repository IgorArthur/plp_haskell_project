module Funcionario where

type FuncionarioID = Int
type Nome = String
type Funcao = String
type Salario = Float

data Funcionario = Funcionario { 
    cod :: FuncionarioID,
    nome :: Nome,
    funcao :: Funcao,
    remuneracao :: Salario 
  }
  deriving (Read, Show)

instance Entity Funcionario where
  entityId funcionario = Funcionario.cod funcionario

instance Show Funcionario where
   show (Funcionario cod nome funcao remuneracao) = "\n-----------------------\n" ++
                                              "ID: " ++ (show cod) ++ "\n" ++
                                              "Nome: " ++ nome ++ "\n" ++
                                              "Função: " ++ funcao ++ "\n" ++
                                              "Salário: " ++ remuneracao ++ 
                                              "\n-----------------------\n"

instance Stringfy Funcionario where
  toString (Funcionario cod nome funcao remuneracao) = show cod ++ "," ++
                                                  nome ++ "," ++
                                                  funcao ++ "," ++
                                                  remuneracao 

instance Read Funcionario where
  readsPrec _ str = do
  let l = splitOn "," str
  let cod = read (l !! 0) :: FuncionarioID
  let nome = l !! 1
  let funcao = l !! 2
  let salario = read (l !! 3) :: Salario
  [(Funcionario cod nome funcao salario, "")]
