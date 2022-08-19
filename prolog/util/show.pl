:- module(show, [showServe/9, showUser/3, showFuncionario/5, showCliente/5]).

:- use_module('./persistence/db.pl').

showServe(ID, Nome, Modelo, Placa, Mecanico, Descricao, Status, Preco, Avaliacao) :-
  writeln('\n-----------------------'),
  format('ID: ~d~n', [ID]),
  format('ID do cliente: ~w~n', [Nome]),
  format('Modelo: ~w~n', [Modelo]),
  format('Placa: ~w~n', [Placa]),
  format('Mecanico: ~w~n', [Mecanico]),
  format('Descrição: ~w~n', [Descricao]),
  format('Status: ~w~n', [Status]),
  format('Preço: R$~w~n', [Preco]),
  format('Avaliação (0 - 5): ~w~n', [Avaliacao]),
  writeln('-----------------------').

showUser(Ssn, Name, Age) :-
  format('CPF: ~w~n', [Ssn]),
  format('Nome: ~w~n', [Name]),
  format('Idade: ~d~n', [Age]).

showFuncionario(FuncionarioID, Ssn, Name, Age, Role) :-
  writeln('\n-----------------------'),
  format('ID: ~d~n', [FuncionarioID]),
  showUser(Ssn, Name, Age),
  format('Função: ~w~n', [Role]),
  writeln('-----------------------').

showCliente(ClienteID, Ssn, Name, Age, Address) :-
  writeln('\n-----------------------'),
  format('ID: ~d~n', [ClienteID]),
  showUser(Ssn, Name, Age),
  format('Endereço: ~w~n', [Address]),
  writeln('-----------------------').


  