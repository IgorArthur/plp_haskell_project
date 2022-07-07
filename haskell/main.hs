import Admin


main = do
  nome <- getLine
  contato <- getLine
  criarAdmin 1 nome contato