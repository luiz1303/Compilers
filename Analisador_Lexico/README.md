# ANALISADOR LÉXICO

Esses foram os arquivos desenvolvidos durante o primeiro projeto da matéria de compiladores. Para testar o seu funcionamento, é necessário o uso da ferramenta **FLEX**.

## Funcionamento do Analisador Léxico
O arquivo `teste.s` foi escrito em determinada linguagem e o arquivo `AnLex.l` possui as especificações para compreender e classificar os tokens dessa linguagem.

No terminal, com acesso a pasta onde se encontram os arquivos, digite o comando:

```bash
flex anlex.l
```
Isto criará o arquivo lex.yy.c. Para compilá-lo, execute:

```bash
gcc lex.yy.c -o output
```
Agora, com `output.exe` criado, é possível classificar os tokens em qualquer arquivo de teste que esteja dentro da linguagem especificada. Veja a seguir, um exemplo do comando de uso com o arquivo `teste.s`:

```bash
./output.exe teste.s
```
