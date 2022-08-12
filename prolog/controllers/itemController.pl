:- module(itemController, [registerCandy/0, registerDrink/0, showCandies/0, showDrinks/0, removeCandy/1,
                           removeDrink/1, showCandyMenuWellRated/0, showCandyMenu/0]).

:- use_module('../persistence/db.pl').
:- use_module('./util/utils.pl').
:- use_module('../util/show.pl').

registerItem(Description, Price) :-
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

registerService :-
  utils:inputNumber("ID do cliente: ", Nome),
  utils:input("Modelo do veículo: ", Modelo),
  utils:input("Placa: ", Placa),
  utils:inputNumber("Mecanico ID: ", Mecanico),
  utils:input("Descrição: ", Descricao),
  utils:inputNumber("Valor Total: ", Preco),
  db:nextId(ID),
  assertz(db:service(ID, Nome, Modelo, Placa, Mecanico, Descricao, "Aberto", Preco, "Não Avaliado!")),
  db:writeService,
  % assertz(db:servico(ID, Nome, Modelo, Placa, Mecanico, Descricao, Status, Preco, Avaliacao)),
  % db:writeServiceP,
  % clear,
  writeln("Servico cadastrado com sucesso!\n"),
  % show:showItem(ID, Name, Description, Price, Score),
  wait.

showServices :-
  db:service(_, _, _, _, _, _, _, _,_),
  writeln("\n\e[1mServiços\e[0m\n"),
  forall(db:service(ID, Nome, Modelo, Placa, Mecanico, Descricao, Status, Preco, Avaliacao), 
         show:showServe(ID, Nome, Modelo, Placa, Mecanico, Descricao, Status, Preco, Avaliacao));
  writeln("\nNão há serviços no sistema.").

showServicesClient(ClientID) :-
  db:service(_, _, _, _, _, _, _, _,_),
  writeln("\n\e[1mServiços\e[0m\n"),
  forall(db:service(ID, ClientID, Modelo, Placa, Mecanico, Descricao, Status, Preco, Avaliacao), 
         show:showServe(ID, ClientID, Modelo, Placa, Mecanico, Descricao, Status, Preco, Avaliacao));
  writeln("\nNão há serviços no sistema.").



  
callRemoveService :-
  (db:service(_, _, _, _, _, _, _, _, _) ->
  (utils:inputNumber("Digite o id do servico: ", ServiceID),
  db:service(ServiceID, _, _, _, _, _, _, _,_),
  removeService(ServiceID);
  writeln("\nNão existe serviço com ID informado."));
  writeln("\nNão há serviços no sistema.")).






removeService(ServiceID) :-
  db:service(ServiceID, Nome, Modelo, Placa, Mecanico, Descricao, Status, Preco, Avaliacao),
  retract(db:service(ServiceID, Nome, Modelo, Placa, Mecanico, Descricao, Status, Preco, Avaliacao)),
  db:writeService,
  clear,
  writeln("\nServico removido com sucesso."),
  show:showServe(ServiceID, Nome, Modelo, Placa, Mecanico, Descricao, Status, Preco, Avaliacao).