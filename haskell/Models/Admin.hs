module Admin where

type Id = Int
type Nome = String
type Role = String

data Admin = Admin
  { cod :: Id,
    nome :: Nome,
    funcao :: Role
  }
  deriving (Read, Show)


criarAdmin :: Id -> Nome -> Role -> IO()
criarAdmin cod nome funcao = do
  let admin = Admin {cod = cod, nome = nome, funcao = funcao}
  file <- appendFile "admin.txt" ("\n" ++ show admin)
  putStrLn "Admin cadastrado com sucesso!"
