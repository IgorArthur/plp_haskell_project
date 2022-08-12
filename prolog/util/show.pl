:- module(show, [showPurchase/5]).

:- use_module('./persistence/db.pl').

showItem(ItemId, Name, Description, Price, ScoreItem) :-
  writeln('\n-----------------------'),
  format('ID: ~d~n', [ItemId]),
  format('Nome: ~w~n', [Name]),
  format('Descrição: ~w~n', [Description]),
  format('Avaliação (0 - 5): ~d~n', [ScoreItem]),
  format('Preço: R$~2f~n', [Price]),
  writeln('-----------------------').

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
         
showPurchase(PurchId, EmpId, CustId, Score, Price) :- 
  writeln('\n-----------------------'),
  format('ID da compra: ~d~n', [PurchId]),
  format('ID do funcionário: ~d~n', [EmpId]),
  format('ID do cliente: ~d~n', [CustId]),
  format('Avaliação (0 - 5): ~d~n', [Score]),
  format('Valor total a pagar: R$~2f~n', [Price]),
  writeln('\n\e[1mPedido:\e[0m'),
  writeln('\n\nDOCES\n'),
  forall((db:purchase_candy(PurchId, CandyId, Quantity),
         db:candy_p(CandyId, Name, Description, CandyPrice, ScoreCandy)),
         (format('Quantidade: ~d~n', [Quantity]),
         showItem(CandyId, Name, Description, CandyPrice, ScoreCandy))),
 
  writeln('\n\nBEBIDAS\n'),
 
  forall((db:purchase_drink(PurchId, DrinkID, Quantity),
         db:drink_p(DrinkID, Name, Description, DrinkPrice, ScoreDrink)),
         (format('Quantidade: ~d~n', [Quantity]),
         showItem(DrinkID, Name, Description, DrinkPrice, ScoreDrink))).

showPerson(Ssn, Name, Age) :-
  format('CPF: ~w~n', [Ssn]),
  format('Nome: ~w~n', [Name]),
  format('Idade: ~d~n', [Age]).

showEmployee(EmployeeID, Ssn, Name, Age, Role) :-
  writeln('\n-----------------------'),
  format('ID: ~d~n', [EmployeeID]),
  showPerson(Ssn, Name, Age),
  format('Função: ~w~n', [Role]),
  writeln('-----------------------').

showCustomer(CustomerID, Ssn, Name, Age, Address) :-
  writeln('\n-----------------------'),
  format('ID: ~d~n', [CustomerID]),
  showPerson(Ssn, Name, Age),
  format('Endereço: ~w~n', [Address]),
  writeln('-----------------------').


  