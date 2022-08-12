:- module(db, [init/0, nextId/1, writeFuncionario/0, writeCliente/0, writeServico/0]).
 
% ServicoID, Name, Description, Price, ScoreCandy
initServico :- dynamic servico/9.
readServico :- consult('./data/servico.bd').
startServico :- exists_file('./data/servico.bd') -> readServico ; initServico.
writeServico :- tell('./data/servico.bd'), listing(servico), told.

% FuncionarioID, Ssn, Name, Age, Role
initFuncionario :- dynamic funcionario/5.
readFuncionario :- consult('./data/funcionario.bd').
startFuncionario :- exists_file('./data/funcionario.bd') -> readFuncionario ; initFuncionario.
writeFuncionario :- tell('./data/funcionario.bd'), listing(funcionario), told.

% ClienteID, Ssn, Name, Age, Address
initCliente :- dynamic cliente/5.
readCliente :- consult('./data/cliente.bd').
startCliente :- exists_file('./data/cliente.bd') -> readCliente ; initCliente.
writeCliente :- tell('./data/cliente.bd'), listing(cliente), told.

initId :- assertz(id(0)).
readId :- consult('./data/id.bd').
startId :- exists_file('./data/id.bd') -> readId ; initId.
writeId :- tell('./data/id.bd'), listing(id), told.
nextId(N) :- id(X), retract(id(X)), N is X + 1, assert(id(N)), writeId.

init :- startId, startFuncionario, startCliente, startServico.