
# Compiladores &mdash; Aula laboratorial 3 

## Exercício 3: *parser* para expressões aritméticas em C

Implemente um *parser* por descida recursiva para expressões artméticas.

Para mais detalhes ver a [folha de exercícios](aula-lab-3.pdf).

Comece por estudar o analisador lexical escrito usando *Flex*.
Pode usar `cd src ; make` e `./parser` para compilar e executar alguns testes
(ficheiros  `tests/input*.txt`).

Notas:

1. o comando `make` executa o Flex para gerar o `lex.yy.c` a partir
   do  `lexer.x`;
   não é necessário executar manualmente
2. não deve acresentar o `lex.yy.c` ao repositório Git (uma
   vez que este será gerado automaticamente).

