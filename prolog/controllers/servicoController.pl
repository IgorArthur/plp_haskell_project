:- module(servicoController, []).

:- use_module('./persistence/db.pl').
:- use_module('../util/show.pl').

callAtualizarStatus :-
  utils:inputNumber("Digite o id do serviço: ", ServicoID),
  db:servico(ServicoID, _, _, _, _, _, _, _, _),
  atualizarStatus(ServicoID);
  writeln("\nNão existe serviço com ID informado.").

atualizarStatus(ServicoID) :-
  db:servico(ServicoID, Nome, Modelo, Placa, Mecanico, Descricao, Status, Preco, Avaliacao),
  utils:input("Digite o novo status: ", NewStatus),
  (retract(db:servico(ServicoID, Nome, Modelo, Placa, Mecanico, Descricao, Status, Preco, Avaliacao)),
    assertz(db:servico(ServicoID, Nome, Modelo, Placa, Mecanico, Descricao, NewStatus, Preco, Avaliacao)),
    db:writeServico,
    show:showServe(ServicoID, Nome, Modelo, Placa, Mecanico, Descricao, NewStatus, Preco, Avaliacao)).

callAddAvaliacao :-
  utils:inputNumber("Digite o id do serviço: ", ServicoID),
  db:servico(ServicoID, _, _, _, _, _, _, _, _),
  avaliarServico(ServicoID);
  writeln("\nNão existe serviço com ID informado.").

avaliarServico(ServicoID) :-
  db:servico(ServicoID, Nome, Modelo, Placa, Mecanico, Descricao, Status, Preco, Avaliacao),
   utils:inputNumber("Digite a avaliação (VALOR INTEIRO ENTRE 0 E 5): ", NewScore),
   (NewScore < 0 -> clear, writeln("\nA avaliação não pode ser negativa.\n"), avaliarServico(ServicoID) ;
    NewScore > 5 -> clear, writeln("\nA avaliação não pode ser maior que 5.\n"), avaliarServico(ServicoID);
    retract(db:servico(ServicoID, Nome, Modelo, Placa, Mecanico, Descricao, Status, Preco, Avaliacao)),
    assertz(db:servico(ServicoID, Nome, Modelo, Placa, Mecanico, Descricao, Status, Preco, NewScore)),
    db:writeServico,
    show:showServe(ServicoID, Nome, Modelo, Placa, Mecanico, Descricao, Status, Preco, NewScore)).
