import Database
import Utils
import Chat
import System.Exit
import Cliente

main = do
    dados <- Database.connect
    let codAtual = (Database.clienteID dados) + 1
    let cliente = Cliente codAtual "Teste" "83 999-888"
    let clientes = Database.clientes dados
    Database.entityToFile cliente "cliente.txt" "cId.txt"
    let newDB = dados {Database.clientes = clientes ++ [cliente], Database.clienteID = codAtual}
    print (newDB)
    print( Database.clientes newDB)