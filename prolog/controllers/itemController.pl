:- module(itemController, []).

:- use_module('../persistence/db.pl').
:- use_module('./util/utils.pl').
:- use_module('../util/show.pl').

registrarItem(Description, Price) :-
  utils:input("Descrição: ", Description),
  utils:inputNumber("Preço: R$", Price).

  % clienteID :: ClienteID,
  % modelo :: ModeloVeiculo,
  % placa :: PlacaVeiculo,
  % mecanicoID :: MecanicoID,
  % descricao :: Descricao,
  % status :: Status,
  % valorTotal :: ValorTotal,
  % avaliacao :: Avaliacao

registrarServico :-
  utils:inputNumber("ID do cliente: ", Nome),
  utils:input("Modelo do veículo: ", Modelo),
  utils:input("Placa: ", Placa),
  utils:inputNumber("Mecanico ID: ", Mecanico),
  utils:input("Descrição: ", Descricao),
  utils:inputNumber("Valor Total: ", Preco),
  db:nextId(ID),
  assertz(db:servico(ID, Nome, Modelo, Placa, Mecanico, Descricao, "Aberto", Preco, "Não Avaliado!")),
  db:writeServico,
  % assertz(db:servico(ID, Nome, Modelo, Placa, Mecanico, Descricao, Status, Preco, Avaliacao)),
  % db:writeServicoP,
  % clear,
  writeln("Servico cadastrado com sucesso!\n"),
  % show:showItem(ID, Name, Description, Price, Score),
  wait.

showServicos :-
  db:servico(_, _, _, _, _, _, _, _,_),
  writeln("\n\e[1mServiços\e[0m\n"),
  forall(db:servico(ID, Nome, Modelo, Placa, Mecanico, Descricao, Status, Preco, Avaliacao), 
         show:showServe(ID, Nome, Modelo, Placa, Mecanico, Descricao, Status, Preco, Avaliacao));
  writeln("\nNão há serviços no sistema.").

showServicosClient(ClientID) :-
  db:servico(_, _, _, _, _, _, _, _,_),
  writeln("\n\e[1mServiços\e[0m\n"),
  forall(db:servico(ID, ClientID, Modelo, Placa, Mecanico, Descricao, Status, Preco, Avaliacao), 
         show:showServe(ID, ClientID, Modelo, Placa, Mecanico, Descricao, Status, Preco, Avaliacao));
  writeln("\nNão há serviços no sistema.").

callRemoveServico :-
  (db:servico(_, _, _, _, _, _, _, _, _) ->
  (utils:inputNumber("Digite o id do servico: ", ServicoID),
  db:servico(ServicoID, _, _, _, _, _, _, _,_),
  removeServico(ServicoID);
  writeln("\nNão existe serviço com ID informado."));
  writeln("\nNão há serviços no sistema.")).

removeServico(ServicoID) :-
  db:servico(ServicoID, Nome, Modelo, Placa, Mecanico, Descricao, Status, Preco, Avaliacao),
  retract(db:servico(ServicoID, Nome, Modelo, Placa, Mecanico, Descricao, Status, Preco, Avaliacao)),
  db:writeServico,
  clear,
  writeln("\nServico removido com sucesso."),
  show:showServe(ServicoID, Nome, Modelo, Placa, Mecanico, Descricao, Status, Preco, Avaliacao).