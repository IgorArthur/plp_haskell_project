:- module(userController, [registrarCliente/0, registrarFuncionario/0, showFuncionarios/0, showClientes/0]).

:- use_module('../persistence/db.pl').
:- use_module('./util/utils.pl').
:- use_module('../util/show.pl').

existsCliente(ClienteID) :-
  db:cliente(ClienteID, _, _, _, _).

existsFuncionario(FuncionarioID) :-
  db:funcionario(FuncionarioID, _, _, _, _).

existsMecanico :-
  db:funcionario(_, _, _, _, "Mecânico").

existsMecanicoByID(FuncionarioID) :-
  db:funcionario(FuncionarioID, _, _, _, "Mecânico").

existsAdmin :-
  db:funcionario(_, _, _, _, "dono").

existsAdminByID(AdminID) :-
  db:funcionario(AdminID, _, _, _, "dono").

saveUser(ID, Ssn, Name, Age, Address) :-
  db:assertz(cliente(ID, Ssn, Name, Age, Address)),
  db:writeCliente.

registrarCliente :- 
  utils:input("CPF: ", Ssn),
  
  ((db:cliente(_, Ssn, _, _, _) -> writeln('\nJá existe um cliente cadastrado com o CPF informado.')) ;
  (db:funcionario(_, Ssn, Name, Age, _) -> format('\nOlá, ~w~n', [Name]) ;
   registrarUser(Name, Age)),
   utils:input("Digite seu endereço: ", Address),
   db:nextId(ID),
   saveUser(ID, Ssn, Name, Age, Address),
   clear,
   writeln("\nCliente cadastrado com sucesso!"),
   show:showCliente(ID, Ssn, Name, Age, Address)),
   utils:wait.  

registrarFuncionario :- 
  utils:input("CPF: ", Ssn),
  (db:funcionario(_, Ssn, _, _, _) -> writeln("\nJá existe um funcionário cadastrado com o CPF informado.");
  (registrarUser(Name, Age),
  Role = "Mecânico",
  db:nextId(ID),
  db:assertz(funcionario(ID, Ssn, Name, Age, Role)),
  clear,
  writeln("\nFuncionário cadastrado com sucesso!\n"),
  db:writeFuncionario,
  show:showFuncionario(ID, Ssn, Name, Age, Role))), utils:wait.

registrarAdmin :-
  writeln("\nNão existe dono!"),
  utils:input("\nDeseja cadastrar um dono? [S - SIM ou qualquer letra para NÃO]: ", Op),
  upcase_atom(Op,'S'),
  utils:input("CPF: ", Ssn),
  registrarUser(Name, Age),
  db:nextId(ID),
  db:assertz(funcionario(ID, Ssn, Name, Age, "dono")),
  clear,
  db:writeFuncionario,
  writeln("Dono cadastrado com sucesso!\n"),
  show:showFuncionario(ID, Ssn, Name, Age, "dono"),
  utils:wait;
  !.

registrarUser(Name, Age) :-
  utils:input("Nome: ", Name),
  utils:inputNumber("Idade: ", Age).

showFuncionarios :-
  clear,
  existsFuncionario(_),
  writeln("\e[1mFuncionários\e[0m\n"),
  forall(db:funcionario(FuncionarioID, Ssn, Name, Age, Role),
         show:showFuncionario(FuncionarioID, Ssn, Name, Age, Role));
  writeln("\nNão há funcionários presentes no sistema.").

showClientes :-
  clear,
  existsCliente(_),
  writeln("\e[1mClientes\e[0m\n"),
  forall(db:cliente(ClienteID, Ssn, Name, Age, Role),
         show:showCliente(ClienteID, Ssn, Name, Age, Role));
  writeln("\nNão há clientes presentes no sistema.").