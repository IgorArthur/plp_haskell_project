:- module(clienteController, [callAddAvaliacao/0]).

:- use_module('./persistence/db.pl').
:- use_module('../util/show.pl').


callAddAvaliacao :-
  utils:inputNumber("Digite o id do serviço: ", ServicoID),
  db:servico(ServicoID, _, _, _, _, _, _, _, _),
  avaliarServico(ServicoID);
  writeln("\nNão existe serviço com ID informado.").

avaliarServico(ServicoID) :-
  db:servico(ServicoID, Nome, Modelo, Placa, Mecanico, Descricao, Status, Preco, Avaliacao),
  show:showServe(ServicoID, Nome, Modelo, Placa, Mecanico, Descricao, Status, Preco, Avaliacao),
  utils:inputNumber("Digite a avaliação (VALOR INTEIRO ENTRE 0 E 5): ", NovaAvaliacao),
  (NovaAvaliacao < 0 -> clear, writeln("\nA avaliação não pode ser negativa.\n"),wait, avaliarServico(ServicoID) ;
   NovaAvaliacao > 5 -> clear, writeln("\nA avaliação não pode ser maior que 5.\n"),wait, avaliarServico(ServicoID);
   retract(db:servico(ServicoID, Nome, Modelo, Placa, Mecanico, Descricao, Status, Preco, Avaliacao)),
   assertz(db:servico(ServicoID, Nome, Modelo, Placa, Mecanico, Descricao, Status, Preco, NovaAvaliacao)),
   db:writeServico,
   clear,
   show:showServe(ServicoID, Nome, Modelo, Placa, Mecanico, Descricao, Status, Preco, NovaAvaliacao)).
