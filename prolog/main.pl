:- use_module('./util/utils.pl').
:- use_module('./util/chat.pl').
:- use_module('./util/show.pl').
:- use_module('./persistence/db.pl').
:- use_module('./controllers/clienteController.pl').
:- use_module('./controllers/adminController.pl').
:- use_module('./controllers/servicoController.pl').

main :-
  db:init,
  start.

start :- 
  clear,
  chat:loginScreen,
  utils:inputNumber("Opção: ", Op),
  (Op =:= 1 -> (adminController:existsAdmin,
                callAdminInteraction;
                adminController:registrarAdmin,
                start);
   Op =:= 2 -> ((adminController:existsMecanico -> 
                (utils:inputNumber("Digite o id do mecânico: ", FuncionarioID),
                adminController:existsFuncionario(FuncionarioID),
                callFuncionarioInteraction(FuncionarioID);
                writeln("\nNão existe mecânico com o ID informado."));
                writeln("\nNão existem mecânicos cadastrados.")),
                wait,
                start);
   Op =:= 3 -> ((adminController:existsCliente(_)->
                (utils:inputNumber("Digite o id do cliente: ", ClienteID),
                adminController:existsCliente(ClienteID),
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
  adminController:existsAdminByID(AdminID),
  adminInteraction;
  writeln("\nNão existe administrador com o ID informado."),
  wait,
  start.

callFuncionarioInteraction(FuncionarioID) :-
  adminController:existsMecanicoByID(FuncionarioID),
  funcionarioInteraction(FuncionarioID);
  writeln("\nO ID informado não pertence a um mecânico."),
  wait,
  start.

adminInteraction :-
  clear,
  chat:slogan,
  chat:opcoesAdmin,
  utils:inputNumber("Opção: ", Op),
  (Op =:= 1 -> adminController:registrarFuncionario;
   Op =:= 2 -> adminController:showFuncionarios, wait;
   Op =:= 3 -> adminController:registrarCliente;
   Op =:= 4 -> servicoController:registrarServico;
   Op =:= 5 -> clear, servicoController:showServicos, wait;
   Op =:= 6 -> servicoController:callRemoveServico, wait;
   Op =:= 7 -> servicoController:callAtualizarStatus, wait;
   Op =:= 8 -> adminController:showClientes, wait;
   Op =:= 9 -> start;
   adminInteraction),
   adminInteraction;
   adminInteraction.


clienteInteraction(ClienteID) :-
  clear,
  chat:slogan,
  chat:opcoesCliente,
  utils:inputNumber("Opção: ", Op),
  (Op =:= 1 -> clear, servicoController:showServicosClient(ClienteID), wait;
   Op =:= 2 -> clienteController:callAddAvaliacao, wait;
   Op =:= 3 -> start;
   clienteInteraction(ClienteID)),
   clienteInteraction(ClienteID);
   clienteInteraction(ClienteID).

funcionarioInteraction(FuncionarioID) :-
  clear,
  chat:slogan,
  adminController:existsFuncionario(FuncionarioID),
  chat:opcoesFuncionario,
  utils:inputNumber("Opção: ", Op),
  (Op =:= 1 -> servicoController:registrarServico;
   Op =:= 2 -> adminController:registrarCliente;
   Op =:= 3 -> clear, servicoController:showServicos, wait;
   Op =:= 4 -> servicoController:callAtualizarStatus, wait;
   Op =:= 5 -> start;
   funcionarioInteraction(FuncionarioID)),
   funcionarioInteraction(FuncionarioID);
   funcionarioInteraction(FuncionarioID).
