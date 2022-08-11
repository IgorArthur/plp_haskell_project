:- module(itemController, [registerCandy/0, registerDrink/0, showCandies/0, showDrinks/0, removeCandy/1,
                           removeDrink/1, showCandyMenuWellRated/0, showCandyMenu/0]).

:- use_module('../persistence/db.pl').
:- use_module('./util/utils.pl').
:- use_module('../util/show.pl').

registerItem(Description, Price) :-
  utils:input("Descrição: ", Description),
  utils:inputNumber("Preço: R$", Price).

registerCandy :-
  utils:input("Nome do doce: ", Name),
  registerItem(Description, Price),
  Score is 5,
  db:nextId(ID),
  assertz(db:candy(ID, Name, Description, Price, Score)),
  db:writeCandy,
  assertz(db:candy_p(ID, Name, Description, Price, Score)),
  db:writeCandyP,
  clear,
  writeln("Doce cadastrado com sucesso!\n"),
  show:showItem(ID, Name, Description, Price, Score),
  wait.

  % clienteID :: ClienteID,
  % modelo :: ModeloVeiculo,
  % placa :: PlacaVeiculo,
  % mecanicoID :: MecanicoID,
  % descricao :: Descricao,
  % status :: Status,
  % valorTotal :: ValorTotal

registerService :-
  utils:input("Nome do cliente: ", Nome),
  utils:input("modelo do veículo: ", Modelo),
  utils:input("Placa: ", Placa),
  utils:input("Mecanico ID: ", Mecanico),
  utils:input("Descrição: ", Descricao),
  utils:input("Valor Total: ", Preco),
  db:nextId(ID),
  assertz(db:service(ID, Nome, Modelo, Placa, Mecanico, Descricao, "Aberto", Preco)),
  db:writeService,
  % assertz(db:servico(ID, Nome, Modelo, Placa, Mecanico, Descricao, Status, Preco)),
  % db:writeServiceP,
  % clear,
  writeln("Servico cadastrado com sucesso!\n"),
  % show:showItem(ID, Name, Description, Price, Score),
  wait.

registerDrink :-
  utils:input("Nome da bebida: ", Name),
  registerItem(Description, Price),
  Score is 5,
  db:nextId(ID),
  assertz(db:drink(ID, Name, Description, Price, Score)),
  db:writeDrink,
  assertz(db:drink_p(ID, Name, Description, Price, Score)),
  db:writeDrinkP,
  clear,
  writeln("Bebida cadastrado com sucesso!\n"),
  show:showItem(ID, Name, Description, Price, Score),
  wait.

showCandies :-
  db:candy(_, _, _, _, _),
  writeln("\n\e[1mDoces\e[0m\n"),
  forall(db:candy(CandyID, Name, Description, CandyPrice, CandyScore), 
         show:showItem(CandyID, Name, Description, CandyPrice, CandyScore));
  writeln("\nNão há doces presentes no sistema.").
  
showServices :-
  db:service(_, _, _, _, _, _, _, _),
  writeln("\n\e[1mServiços\e[0m\n"),
  forall(db:service(ID, Nome, Modelo, Placa, Mecanico, Descricao, Status, Preco), 
         show:showServe(ID, Nome, Modelo, Placa, Mecanico, Descricao, Status, Preco));
  writeln("\nNão há serviços no sistema.").

showDrinks :-
  db:drink(_, _, _, _, _),
  writeln("\n\e[1mBebidas\e[0m\n"),
  forall(db:drink(DrinkID, Name, Description, DrinkPrice, DrinkScore), 
         show:showItem(DrinkID, Name, Description, DrinkPrice, DrinkScore));
  writeln("\nNão há bebidas presentes no sistema.").


callRemoveCandy :-
  (db:candy(_, _, _, _, _) ->
  (utils:inputNumber("Digite o id do doce: ", CandyID),
  db:candy(CandyID, _, _, _, _),
  removeCandy(CandyID);
  writeln("\nNão existe doce com ID informado."));
  writeln("\nNão há doces no sistema.")).
  
callRemoveService :-
  (db:service(_, _, _, _, _, _, _, _) ->
  (utils:inputNumber("Digite o id do servico: ", ServiceID),
  db:service(ServiceID, _, _, _, _, _, _, _),
  removeService(ServiceID);
  writeln("\nNão existe serviço com ID informado."));
  writeln("\nNão há serviços no sistema.")).

callRemoveDrink :-
  (db:drink(_, _, _, _, _)->
  (utils:inputNumber("Digite o id da bebida: ", DrinkID),
  db:drink(DrinkID, _, _, _, _),
  removeDrink(DrinkID);
  writeln("\nNão existe bebida com ID informado."));
  writeln("\nNão há bebidas no sistema.")). 

removeCandy(CandyID) :-
  db:candy(CandyID, Name, Description, CandyPrice, CandyScore),
  retract(db:candy(CandyID, Name, Description, CandyPrice, CandyScore)),
  db:writeCandy,
  clear,
  writeln("\nDoce removido com sucesso."),
  show:showItem(CandyID, Name, Description, CandyPrice, CandyScore).


removeService(ServiceID) :-
  db:service(ServiceID, Nome, Modelo, Placa, Mecanico, Descricao, Status, Preco),
  retract(db:service(ServiceID, Nome, Modelo, Placa, Mecanico, Descricao, Status, Preco)),
  db:writeService,
  clear,
  writeln("\nServico removido com sucesso."),
  show:showServe(ServiceID, Nome, Modelo, Placa, Mecanico, Descricao, Status, Preco).

removeDrink(DrinkID) :-
  db:drink(DrinkID, Name, Description, DrinkPrice, DrinkScore),
  retract(db:drink(DrinkID, Name, Description, DrinkPrice, DrinkScore)),
  db:writeDrink,
  clear,
  writeln("\nBebida removida com sucesso."),
  show:showItem(DrinkID, Name, Description, DrinkPrice, DrinkScore).

showCandyMenuWellRated :-
  clear,
  writeln('\e[1mProdutos bem avaliados\e[0m'),
  writeln('\n\n\e[1mDOCES\e[0m\n'),
  ((db:candy(_, _, _, _, ScoreCandyT), ScoreCandyT >= 4),
  forall((db:candy(CandyID, Name, Description, Price, ScoreCandy),
          ScoreCandy >= 4),
          show:showItem(CandyID, Name, Description, Price, ScoreCandy));
  writeln("\nNão há doces bem avaliados no sistema.")),
  
  writeln('\n\n\e[1mBEBIDAS\e[0m\n'),
  ((db:drink(_, _, _, _, ScoreDrinkT), ScoreDrinkT >= 4),
  forall((db:drink(DrinkID, Name, Description, Price, ScoreDrink),
          ScoreDrink >= 4),
          show:showItem(DrinkID, Name, Description, Price, ScoreDrink));
  writeln("\nNão há bebidas bem avaliadas no sistema.")),
  wait.

showCandyMenu :-
  clear,
  writeln("\e[1mCardápio\e[0m\n"),
  showCandies,
  showDrinks,
  wait.