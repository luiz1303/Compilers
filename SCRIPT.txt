flex scanner.l
bison -d parser.y
gcc -c -o armazenamento.o armazenamento.c
gcc -c -o parser.o parser.tab.c
gcc -c -o main.o main.c
gcc -o main armazenamento.o parser.o main.o
.\main .\arquivos_teste\teste3.sml