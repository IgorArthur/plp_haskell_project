module Chat where



slogan:: String
slogan =  "\n-----------------------------------------\n" ++
          "Bem-vindo ao Gerenciador de Oficinas 3000" ++
          "\n-----------------------------------------\n"

options :: String
options = 
          "\nComo você deseja logar no sistema?\n" ++
          "\n(1) Logar como administrador\n" ++
          "(2) Logar como mecânico\n" ++
          "(3) Logar como cliente\n" ++
          "(4) Sair\n" ++
          "\n-----------------------\n"

adminOptions :: String
adminOptions = "\n--------------------------\n" ++
               "Funcionalidades do Administrador" ++
               "\n--------------------------\n" ++
               "\nO que você deseja fazer?\n" ++
               "\n(1) Cadastrar mecânico\n" ++
               "(2) Cadastrar cliente\n" ++
               "(3) Cadastrar serviço\n" ++
               "(4) Excluir serviço\n" ++
               "(5) Voltar\n" ++
               "\n-----------------------\n"

clienteOptions :: String
clienteOptions = "\n-----------------------------\n" ++
                  "Funcionalidades do Cliente" ++
                  "\n-----------------------------\n" ++
                  "\nO que você deseja fazer?\n" ++
                  "\n(1) Visualizar serviços\n" ++
                  "(2) Avaliar serviço\n" ++
                  "(3) Voltar\n" ++
                  "\n-----------------------\n"

funcionarioOptions :: String
funcionarioOptions = "\n---------------------------------\n" ++
                  "Funcionalidades do Mecânico" ++
                  "\n---------------------------------\n" ++
                  "\nO que você deseja fazer?\n" ++
                  "\n(1) Cadastrar serviço\n" ++
                  "(2) Cadastrar cliente\n" ++
                  "(3) Voltar\n" ++
                  "\n-----------------------\n"