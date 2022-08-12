:- use_module('./util/utils.pl').
:- use_module('./util/chat.pl').
:- use_module('./util/show.pl').
:- use_module('./persistence/db.pl').
:- use_module('./controllers/purchaseController.pl').
:- use_module('./controllers/personController.pl').
:- use_module('./controllers/itemController.pl').

main :-
  db:init,
  start.

start :- 
  clear,
  chat:loginScreen,
  utils:inputNumber("Opção: ", Op),
  (Op =:= 1 -> (personController:existsOwner,
                callOwnerInteraction;
                personController:registerOwner,
                start);
   Op =:= 2 -> ((personController:existsSeller -> 
                (utils:inputNumber("Digite o id do mecânico: ", EmployeeID),
                personController:existsEmployee(EmployeeID),
                callEmployeeInteraction(EmployeeID);
                writeln("\nNão existe mecânico com o ID informado."));
                writeln("\nNão existem mecânicos cadastrados.")),
                wait,
                start);
   Op =:= 3 -> ((personController:existsCustomer(_)->
                (utils:inputNumber("Digite o id do cliente: ", CustomerID),
                personController:existsCustomer(CustomerID),
                customerInteraction(CustomerID);
                writeln("\nNão existe cliente com o ID informado."));
                writeln("\nNão existem clientes cadastrados.")),
                wait,
                start);
   Op =:= 4 -> writeln("\n\e[1mVolte sempre!\n\n\e[0m"), halt;
   start), 
   start;
   start.

callOwnerInteraction :-
  utils:inputNumber("Digite o id do administrador: ", OwnerID),
  personController:existsOwnerByID(OwnerID),
  ownerInteraction;
  writeln("\nNão existe administrador com o ID informado."),
  wait,
  start.

callEmployeeInteraction(EmployeeID) :-
  personController:existsSellerByID(EmployeeID),
  employeeInteraction(EmployeeID);
  writeln("\nO ID informado não pertence a um mecânico."),
  wait,
  start.

ownerInteraction :-
  clear,
  chat:slogan,
  chat:ownerOptions,
  utils:inputNumber("Opção: ", Op),
  (Op =:= 1 -> personController:registerEmployee;
   Op =:= 2 -> personController:showEmployees, wait;
   Op =:= 3 -> personController:registerCustomer;
   Op =:= 4 -> itemController:registerService;
   Op =:= 5 -> clear, itemController:showServices, wait;
   Op =:= 6 -> itemController:callRemoveService, wait;
   Op =:= 7 -> purchaseController:callUpdateStatus, wait;
   Op =:= 8 -> personController:showCustomers, wait;
   Op =:= 9 -> start;
   ownerInteraction),
   ownerInteraction;
   ownerInteraction.


customerInteraction(CustomerID) :-
  clear,
  chat:slogan,
  chat:customerOptions,
  utils:inputNumber("Opção: ", Op),
  (Op =:= 1 -> clear, itemController:showServicesClient(CustomerID), wait;
   Op =:= 2 -> purchaseController:callAddAvaliacao, wait;
   Op =:= 3 -> start;
   customerInteraction(CustomerID)),
   customerInteraction(CustomerID);
   customerInteraction(CustomerID).

employeeInteraction(EmployeeID) :-
  clear,
  chat:slogan,
  personController:existsEmployee(EmployeeID),
  chat:employeeOptions,
  utils:inputNumber("Opção: ", Op),
  (Op =:= 1 -> itemController:registerService;
   Op =:= 2 -> personController:registerCustomer;
   Op =:= 3 -> clear, itemController:showServices, wait;
   Op =:= 4 -> purchaseController:showPurchasesByEmployee(EmployeeID), wait;
   Op =:= 5 -> start;
   employeeInteraction(EmployeeID)),
   employeeInteraction(EmployeeID);
   employeeInteraction(EmployeeID).
