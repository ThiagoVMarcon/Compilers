# Compiladores &mdash; Folha laboratorial 4

## Exercício 4: uma calculadora para expressões aritméticas simples

Implemente em C uma calculadora para operações aritméticas
simples usando geradores de analisadores lexicais e sintáticos.

Para detalhes deve consultar a [folha de exercícios](aula-lab-4.pdf).


## Recomendações 

* Deve editar o esqueleto de código fonte no diretório `src`
* Não adicione ao repositório Git ficheiros gerados automaticamente;
  exemplo: deve modificar e fazer *commit* dos ficheiros
  `lexer.x` e `parser.y` mas **não adicione** 
  `parser.tab.c` e `lex.yy.c` (que são gerados a partir os anteriores)
* Para construir e executar o programa deve usar a ferramenta `make`:
  
  ~~~
  $ cd src
  $ make
  ~~~
  
  Obtém um executável `calc`:
  
  ~~~
  $ echo "1+2+3" | ./calc
  6.000000
  ~~~

* Experimente correr os exemplos em (`tests/input*.txt`) e compare com os
  resultados esperados (`tests/output*.txt`)


  
## Documentação 


Flex 

:   [https://westes.github.io/flex/manual/](https://westes.github.io/flex/manual/)

Bison

:   [https://www.gnu.org/software/bison/manual/html_node/index.html](https://www.gnu.org/software/bison/manual/html_node/index.html)

*Makefiles*

:     [https://www.cs.colby.edu/maxwell/courses/tutorials/maketutor/](https://www.cs.colby.edu/maxwell/courses/tutorials/maketutor/)
