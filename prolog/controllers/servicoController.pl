:- module(servicoController, [registrarServico/0,showServicos/0,showServicosClient/1, callRemoveServico/0]).

:- use_module('../persistence/db.pl').
:- use_module('../util/utils.pl').
:- use_module('../util/show.pl').
:- use_module('./adminController.pl').


registrarServico :-
  utils:inputNumber("ID do cliente: ", Nome),
  (userController: existsCliente(Nome) ->
  utils:input("Modelo do veículo: ", Modelo),
  utils:input("Placa: ", Placa),
  utils:inputNumber("Mecanico ID: ", Mecanico),
  (userController:existsFuncionario(Mecanico) -> 
  utils:input("Descrição: ", Descricao),
  utils:inputNumber("Valor Total: ", Preco),
  db:nextId(ID),
  assertz(db:servico(ID, Nome, Modelo, Placa, Mecanico, Descricao, "Aberto", Preco, "Não Avaliado!")),
  db:writeServico,
  writeln("Servico cadastrado com sucesso!\n"),
  wait;
  writeln("\nNão existe mecânico com esse ID.\n"), wait);
  writeln("\nNão existe cliente com esse ID.\n"), wait).

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

callAtualizarStatus :-
  utils:inputNumber("Digite o id do serviço: ", ServicoID),
  db:servico(ServicoID, Nome, Modelo, Placa, Mecanico, Descricao, Status, Preco, Avaliacao),
  show:showServe(ServicoID, Nome, Modelo, Placa, Mecanico, Descricao, Status, Preco, Avaliacao),
  atualizarStatus(ServicoID);
  writeln("\nNão existe serviço com ID informado.").

atualizarStatus(ServicoID) :-
  db:servico(ServicoID, Nome, Modelo, Placa, Mecanico, Descricao, Status, Preco, Avaliacao),
  utils:input("Digite o novo status: ", NewStatus),
  (retract(db:servico(ServicoID, Nome, Modelo, Placa, Mecanico, Descricao, Status, Preco, Avaliacao)),
    assertz(db:servico(ServicoID, Nome, Modelo, Placa, Mecanico, Descricao, NewStatus, Preco, Avaliacao)),
    db:writeServico,
    clear,
    show:showServe(ServicoID, Nome, Modelo, Placa, Mecanico, Descricao, NewStatus, Preco, Avaliacao)).

