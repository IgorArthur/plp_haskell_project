:- module(chat, [slogan/0, chatLogin/0, loginScreen/0, ownerOptions/0, customerOptions/0, employeeOptions/0]).

slogan :-
  string_concat("--------------------------------------------------------------------------------------\n",
     "                                                                                     |\n",CANDY_STR1),
  string_concat(CANDY_STR1, " ██████  █████  ███    ██ ██████  ██    ██     ██       █████  ███    ██ ██████      |\n",CANDY_STR2),
  string_concat(CANDY_STR2, "██      ██   ██ ████   ██ ██   ██  ██  ██      ██      ██   ██ ████   ██ ██   ██     |\n",CANDY_STR3),
  string_concat(CANDY_STR3, "██      ███████ ██ ██  ██ ██   ██   ████       ██      ███████ ██ ██  ██ ██   ██     |\n",CANDY_STR4),
  string_concat(CANDY_STR4, "██      ██   ██ ██  ██ ██ ██   ██    ██        ██      ██   ██ ██  ██ ██ ██   ██     |\n",CANDY_STR5),
  string_concat(CANDY_STR5, " ██████ ██   ██ ██   ████ ██████     ██        ███████ ██   ██ ██   ████ ██████      |\n                                                                                     |\n",CANDY_STR6),
  string_concat(CANDY_STR6, "   ___     .----.     ___",CHOCO_STR1),
  string_concat(CHOCO_STR1, "       ___  ___  ___  ___  ___.---------------.             |\n",CHOCO_STR2),
  string_concat(CHOCO_STR2, "   \\  -.  /      \\  .-  /",CHOCO_STR3),
  string_concat(CHOCO_STR3, "     .'\\__\\'\\__\\'\\__\\'\\__\\'\\__,`   .  ____ ___ \\            |\n",CHOCO_STR4),
  string_concat(CHOCO_STR4, "   > -=.\\/        \\/.=- <",CHOCO_STR5),
  string_concat(CHOCO_STR5, "     |\\/ __\\/ __\\/ __\\/ __\\/ _:\\   |`.  \\  \\___ \\           |\n",CHOCO_STR6),
  string_concat(CHOCO_STR6, "   > -='/\\        /\\'=- <",CHOCO_STR7),
  string_concat(CHOCO_STR7, "     \\'\\__\\'\\__\\'\\__\\'\\__\\'\\_`. \\__|--`. \\  \\___ \\          |\n",CHOCO_STR8),
  string_concat(CHOCO_STR8, "  /__.-'  \\      /  '-.__\\",CHOCO_STR9),
  string_concat(CHOCO_STR9, "     \\\\/ __\\/ __\\/ __\\/ __\\/ __:                 \\         |\n",CHOCO_STR10),
  string_concat(CHOCO_STR10, "           '-..-'",CHOCO_STR11),
  string_concat(CHOCO_STR11, "               \\\\'\\__\\'\\__\\'\\__\\ \\__\\'\\_:-----------------'         |\n",CHOCO_STR12),
  string_concat(CHOCO_STR12,  "                                 \\\\/   \\/   \\/   \\/   \\/ :                 |         |\n",CHOCO_STR13),
  string_concat(CHOCO_STR13, "                                  \\|______________________:________________|         |\n                                                                                     |\n",CHOCO_STR14),
  string_concat(CHOCO_STR14, "--------------------------------------------------------------------------------------\n\n",CHOCO_STR15),
  writeln(CHOCO_STR15).

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

ownerOptions :-
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

customerOptions :-
  writeln('----------------------------------'),
  writeln('Funcionalidades do \e[1mCliente\e[0m       |'),
  writeln('----------------------------------'),
  writeln('O que você deseja fazer?'),
  writeln('(1) Vizualizar servicos'),
  writeln('(2) Avaliar servico'),
  writeln('(3) VOLTAR'),
  writeln('----------------------------------').

employeeOptions :-
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
