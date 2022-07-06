module Chat where

menu :: String
menu = 
          "\nQual o seu tipo de usuário?\n" ++
          "\n(1) Administrador\n" ++
          "(2) Mecânico\n" ++
          "(3) Cliente\n" ++
          "(4) Sair\n" ++
          "\n-----------------------\n"

adminOptions :: String
adminOptions = "\n--------------------------\n" ++
               "Funcionalidades do Administrador |" ++
               "\n--------------------------\n" ++
               "\nEscolha uma operação\n" ++
               "\n(1) Cadastrar mecânico\n" ++
               "(2) Cadastrar cliente\n" ++
               "(3) Visualizar estatísticas\n" ++
               "(4) Cadastrar serviço\n" ++
               "(5) Editar serviço\n" ++
               "(6) VOLTAR\n" ++
               "\n-----------------------\n"

clientOptions :: String
clientOptions = "\n-----------------------------\n" ++
                  "Funcionalidades do Cliente  |" ++
                  "\n-----------------------------\n" ++
                  "\nEscolha uma operação\n" ++
                  "\n(1) Visualizar status do serviço\n" ++
                  "(2) Avaliar serviço\n" ++
                  "(3) Visualizar estatísticas\n" ++
                  "(6) VOLTAR\n" ++
                  "\n-----------------------\n"

mechanOptions :: String
mechanOptions = "\n---------------------------------\n" ++
                  "Funcionalidades do Mecânico  |" ++
                  "\n---------------------------------\n" ++
                  "\nEscolha uma opção\n" ++
                  "\n(1) Inserir orçamento\n" ++
                  "(2) Editar orçamento\n" ++
                  "(3) Visualizar estatísticas\n" ++
                  "(5) VOLTAR\n" ++
                  "\n-----------------------\n"