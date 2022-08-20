<h3 align="center">Gerenciamento de Oficinas
</h3>

---

<p align="center"> Sistema para gerenciamento de serviços realizados em uma oficina automotiva. 
    <br>
</p>

## 📌 Indíce

- [Especificação](#sobre)
- [Intruções para execução](#exe)

## 📖 Especificação <a name = "sobre"></a>

Descrição completa do sistema: [clique aqui](https://docs.google.com/document/d/1aqAX4K84riLpviZXa8KZhCga0ddvvWbp5DI-ZiwW9UI/edit)

## 💻 Instruções para execução <a name = "exe"></a>

Instruções de como reproduzir uma cópia do projeto para desenvolvê-lo ou testá-lo:

### Pré-requisitos

Para a execução do projeto em Haskell é necessário obter as seguintes isntalações
- Compilador Haskell (GHC)
- [Plataforma Haskell](https://www.haskell.org/downloads/)
- Pacote `cabal` para instalar as bibliotecas `split` e `strict`

Para a execução do projeto em Prolog é necessário obter as seguintes isntalações
- Compilador Prolog (SWIPL)
- [SWI-Prolog](https://www.swi-prolog.org/download/stable)
- Nenhuma outra depedência é necessária.

### Observações

## Haskell
São necessários alguns cuidados ao iniciar a execução do projeto "zerado". Neste caso, entende-se por "zerado" o cenário em que os arquivos de armazenamento estão vazios, ou seja, sem nenhum registro. Logo, é necessário:
- Os arquivos que armazenam id ([nomeDoArquivo]Id.txt) devem ser inicializados com o valor 0 e sem linhas em branco após esse valor para que esse valor seja atualizado devidamente no decorrer da execução do programa
- Para os demais arquivos, não devem ocorrer linhas em branco após a primeira linha para evitar erros de `parse`

## Prolog
Caso queira reiniciar o sistema e limpar os dados armazenados, basta deletar os arquivos `.db` na pasta `data` que serão criados quando o sistema executar.
