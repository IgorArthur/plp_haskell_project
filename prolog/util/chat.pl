:- module(chat, [slogan/0, chatLogin/0, loginScreen/0, opcoesAdmin/0, opcoesCliente/0, opcoesFuncionario/0]).

slogan :-
  string_concat("--------------------------------------------------------------------------------------\n",
     "                                                                             \n",OFICINA_STR1),
  string_concat(OFICINA_STR1, "████████ ████████ ██ ███████ ██  ████████  ████████  \n",OFICINA_STR2),
  string_concat(OFICINA_STR2, "██    ██ ██          ██          ██    ██  ██    ██  \n",OFICINA_STR3),
  string_concat(OFICINA_STR3, "██    ██ ██████   ██ ██      ██  ██    ██  ████████  \n",OFICINA_STR4),
  string_concat(OFICINA_STR4, "██    ██ ██       ██ ██      ██  ██    ██  ██    ██  \n",OFICINA_STR5),
  string_concat(OFICINA_STR5, "████████ ██       ██ ███████ ██  ██    ██  ██    ██  \n                                                                            |\n",OFICINA_STR6),
  writeln(OFICINA_STR6).

chatLogin :-
  writeln('Como você deseja logar no sistema?\n'),
  writeln('(1) Logar como administrador'),
  writeln('(2) Logar como mecânico'),
  writeln('(3) Logar como cliente'),
  writeln('(4) Sair\n'),
  writeln('----------------------').

loginScreen :-
  slogan,
  chatLogin.

opcoesAdmin :-
  writeln('--------------------------'),
  writeln('Funcionalidades do \e[1mDono\e[0m  |'),
  writeln('--------------------------'),
  writeln('O que você deseja fazer?'),
  writeln('(1) Cadastrar mecânico'),
  writeln('(2) Ver funcionarios'),
  writeln('(3) Cadastrar cliente'),
  writeln('(4) Cadastrar servico'),
  writeln('(5) Visualizar servicos'),
  writeln('(6) Excluir servico'),
  writeln('(7) Atualizar status de um servico'),
  writeln('(8) Vizualizar clientes'),
  writeln('(9) VOLTAR'),
  writeln('--------------------------').

opcoesCliente :-
  writeln('----------------------------------'),
  writeln('Funcionalidades do \e[1mCliente\e[0m       |'),
  writeln('----------------------------------'),
  writeln('O que você deseja fazer?'),
  writeln('(1) Vizualizar servicos'),
  writeln('(2) Avaliar servico'),
  writeln('(3) VOLTAR'),
  writeln('----------------------------------').

opcoesFuncionario :-
  writeln('----------------------------------'),
  writeln('Funcionalidades do \e[1mFuncionário\e[0m   |'),
  writeln('----------------------------------'),
  writeln('O que você deseja fazer?'),
  writeln('(1) Cadastrar servico'),
  writeln('(2) Cadastrar cliente'),
  writeln('(3) Vizualizar servicos'),
  writeln('(4) Atualizar status de servico'),
  writeln('(5) VOLTAR'),
  writeln('---------------------------------').
