# ANALISADOR SINTÁTICO

Arquivos desenvolvidos durante o segundo projeto da matéria de compiladores. Para testar o seu funcionamento, é necessário o uso da ferramenta **FLEX** em conjunto com **BISON**.

## **INTRODUÇÃO:**
Os arquivos `fatorial.sml` e `maior.sml`  foram escritos em determinada linguagem chamada `Small L`. O objetivo é realizar a **análise léxica** e **sintática** para identificar se os arquivos citados estão dentro das especificações da gramática fornecida para a linguagem, que pode ser vista abaixo. 

O arquivo `scanner.l` possui as especificações para fazer a **análise léxica**: Identificar os tokens da linguagem e apontar eventuais erros léxicos (Como nomes de variáveis do tipo *"123teste"*, por exemplo).

O arquivo `parser.y`, por sua vez, é responsável pela **análise sintática**, que define se a estrutura de cada sentença segue a gramática proposta para a linguagem.

Por fim, o arquivo `main.c`, é o responsável por fazer a
correta leitura das entradas e relacionar os arquivos.

No terminal, com acesso à pasta onde se encontram os arquivos, utilize:



## **COMO EXECUTAR?**

```bash
flex scanner.l
bison -d parser.y
gcc -c -o parser.o parser.tab.c
gcc -c -o main.o main.c
gcc -o main parser.o main.o
.\main .\arquivos_teste\nome-arquivo
```
Em **nome-arquivo**, substitua por: `fatorial.sml` ou `maior.sml`.


## **GRAMÁTICA DA LINGUAGEM SMALL L:**

```
<programa> ::= programa <identificador> ; <bloco>

<bloco> ::= var <declaracao> inicio <comandos> fim

<declaracao> ::= <nome_var> : <tipo> ; | <nome_var > : <tipo> ; <declaracao>

<nome_var> ::= <identificador> | <identificador> , <nome_var>

<tipo> ::= inteiro | real | booleano

<comandos> ::= <comando> | <comando> ; <comandos>

<comando> ::= <atribuicao> | <condicional> | <enquanto> | <leitura> | <escrita>

<atribuicao> ::= <identificador> := <expressão>

<condicional> ::= se <expressão> entao <comandos> |
 se <expressão> entao <comandos> senao <comandos>

<enquanto> ::= enquanto <expressao> faca <comandos>

<leitura> ::= leia ( <identificador> )

<escrita> ::= escreva ( <identificador> )

<expressao> ::= <simples> | <simples> <op_relacional> <simples>

<op_relacional> ::= <> | = | < | > | <= | >=

<simples> ::= <termo> <operador> <termo> | <termo>

<operador> ::= + | - | ou

<termo> ::= <fator> | <fator> <op> <fator>

<op> ::= * | div | e

<fator> ::= <identificador> | <numero> | (<expressao>) | verdadeiro | falso | nao <fator>

<identificador> ::= id

<numero> ::= num
```

**• Comentários:** Uma vez que os comentários servem apenas como documentação do código fonte, ao realizar a compilação deste código faz-se necessário eliminar todo o conteúdo entre seus delimitadores: { }.

**• Tipos Numéricos:** Inteiros ({naturais positivos e negativos}) e Reais (float)

**• Identificadores:** Letras seguidas de zero ou mais letras ou dígitos



## **REFERÊNCIAS:**
• https://www.ibm.com/docs/pt-br/zos/2.4.0?topic=tools-tutorial-using-lex-yacc
