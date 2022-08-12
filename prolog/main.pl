:- use_module('./util/utils.pl').
:- use_module('./util/chat.pl').
:- use_module('./util/show.pl').
:- use_module('./persistence/db.pl').
:- use_module('./controllers/servicoController.pl').
:- use_module('./controllers/userController.pl').
:- use_module('./controllers/itemController.pl').

main :-
  db:init,
  start.

start :- 
  clear,
  chat:loginScreen,
  utils:inputNumber("Opção: ", Op),
  (Op =:= 1 -> (userController:existsAdmin,
                callAdminInteraction;
                userController:registrarAdmin,
                start);
   Op =:= 2 -> ((userController:existsMecanico -> 
                (utils:inputNumber("Digite o id do mecânico: ", FuncionarioID),
                userController:existsFuncionario(FuncionarioID),
                callFuncionarioInteraction(FuncionarioID);
                writeln("\nNão existe mecânico com o ID informado."));
                writeln("\nNão existem mecânicos cadastrados.")),
                wait,
                start);
   Op =:= 3 -> ((userController:existsCliente(_)->
                (utils:inputNumber("Digite o id do cliente: ", ClienteID),
                userController:existsCliente(ClienteID),
                clienteInteraction(ClienteID);
                writeln("\nNão existe cliente com o ID informado."));
                writeln("\nNão existem clientes cadastrados.")),
                wait,
                start);
   Op =:= 4 -> writeln("\n\e[1mVolte sempre!\n\n\e[0m"), halt;
   start), 
   start;
   start.

callAdminInteraction :-
  utils:inputNumber("Digite o id do administrador: ", AdminID),
  userController:existsAdminByID(AdminID),
  adminInteraction;
  writeln("\nNão existe administrador com o ID informado."),
  wait,
  start.

callFuncionarioInteraction(FuncionarioID) :-
  userController:existsMecanicoByID(FuncionarioID),
  funcionarioInteraction(FuncionarioID);
  writeln("\nO ID informado não pertence a um mecânico."),
  wait,
  start.

adminInteraction :-
  clear,
  chat:slogan,
  chat:opcoesAdmin,
  utils:inputNumber("Opção: ", Op),
  (Op =:= 1 -> userController:registrarFuncionario;
   Op =:= 2 -> userController:showFuncionarios, wait;
   Op =:= 3 -> userController:registrarCliente;
   Op =:= 4 -> itemController:registrarServico;
   Op =:= 5 -> clear, itemController:showServicos, wait;
   Op =:= 6 -> itemController:callRemoveServico, wait;
   Op =:= 7 -> servicoController:callAtualizarStatus, wait;
   Op =:= 8 -> userController:showClientes, wait;
   Op =:= 9 -> start;
   adminInteraction),
   adminInteraction;
   adminInteraction.


clienteInteraction(ClienteID) :-
  clear,
  chat:slogan,
  chat:opcoesCliente,
  utils:inputNumber("Opção: ", Op),
  (Op =:= 1 -> clear, itemController:showServicosClient(ClienteID), wait;
   Op =:= 2 -> servicoController:callAddAvaliacao, wait;
   Op =:= 3 -> start;
   clienteInteraction(ClienteID)),
   clienteInteraction(ClienteID);
   clienteInteraction(ClienteID).

funcionarioInteraction(FuncionarioID) :-
  clear,
  chat:slogan,
  userController:existsFuncionario(FuncionarioID),
  chat:opcoesFuncionario,
  utils:inputNumber("Opção: ", Op),
  (Op =:= 1 -> itemController:registrarServico;
   Op =:= 2 -> userController:registrarCliente;
   Op =:= 3 -> clear, itemController:showServicos, wait;
   Op =:= 4 -> servicoController:callAtualizarStatus, wait;
   Op =:= 5 -> start;
   funcionarioInteraction(FuncionarioID)),
   funcionarioInteraction(FuncionarioID);
   funcionarioInteraction(FuncionarioID).
