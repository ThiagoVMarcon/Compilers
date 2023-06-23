/* Tests for an interpreter for expressions and statements
 * Pedro Vasconcelos, 2022
 */
#include "ast.h"
#include "table.h"
#include "interpret.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>



/* Global variables for 3 AST examples;
 * Note that statements contains expressions so these will also 
 * test the expression interpreter
 */
Stm example1, example2, example3;

/* Setup the examples; runs only once at before testing
 */
void setup_examples(void) {
  example1 =
    mk_compound(mk_assign("a", mk_opexp(mk_numexp(5), PLUS, mk_numexp(3))),
                mk_assign("b", mk_opexp(mk_idexp("a"), MINUS, mk_numexp(2))));
  example2 =
    mk_compound(mk_assign("a", mk_opexp(mk_numexp(5), PLUS, mk_numexp(3))),
                mk_compound(mk_incr("a"),
                            mk_assign("b", mk_opexp(mk_idexp("a"), TIMES, mk_numexp(2)))));
  example3 =
    mk_compound(mk_assign("a", mk_numexp(2)),
                mk_compound(mk_incr("a"),
                            mk_compound(mk_assign("b",
                                                  mk_opexp(mk_idexp("a"), PLUS, mk_numexp(1))),
                                        mk_assign("c",
                                                  mk_opexp(mk_idexp("b"), PLUS, mk_numexp(1))))));
}


/* Tests for the interpret_stm function;
 * Note that statements contain (sub)expressions so these
 * will also test interpret_exp
 */ 
void test_interpret(int example) {
  Table tbl;

  printf("Testing interpret_stm\n");
  switch(example) {
  case 1:
    printf("Example 1:\n");
    print_stm(example1); printf("\n");
    
    tbl = interpret_stm(example1, NULL);
    assert( lookup_value(tbl, "a") == 8 &&
            lookup_value(tbl, "b") == 6 );
    break;

  case 2:
    printf("Example 2:\n");
    print_stm(example2); printf("\n");
    
    tbl = interpret_stm(example2, NULL);
    assert( lookup_value(tbl, "a") == 9 &&
            lookup_value(tbl, "b") == 18 );
    break;

  case 3:
    printf("Example 3:\n");
    print_stm(example3); printf("\n");
    
    tbl = interpret_stm(example3, NULL);
    assert( lookup_value(tbl, "a") == 3 &&
            lookup_value(tbl, "b") == 4 &&
            lookup_value(tbl, "c") == 5 );
    break;
  }
}

void test_ids(int example) {
  printf("Testing id_in_stm\n");

  switch(example) {
  case 1:
    printf("Example 1:\n");
    print_stm(example1); printf("\n"); 
    assert( id_in_stm(example1, "a") );
    assert( id_in_stm(example1, "b") );
    assert( !id_in_stm(example1, "c") );
    assert( !id_in_stm(example1, "d") );
    break;

  case 2:
    printf("Example 2:\n");
    print_stm(example2); printf("\n");
    assert( id_in_stm(example2, "a") );
    assert( id_in_stm(example2, "b") );
    assert( !id_in_stm(example2, "c") );
    assert( !id_in_stm(example1, "d") );
    break;

  case 3:
    printf("Example 3:\n");
    print_stm(example3); printf("\n");
    assert( id_in_stm(example3, "a") );
    assert( id_in_stm(example3, "b") );
    assert( id_in_stm(example3, "c") );
    assert( !id_in_stm(example1, "d") );
    break;
  }
}


int main(int argc, char *argv[]) {
  int example;
  setup_examples();

  if(argc==1) {
    test_ids(1);
    test_ids(2);
    test_ids(3);
    test_interpret(1);
    test_interpret(2);
    test_interpret(3);
    exit(0);
  }
 
  if(argc == 3 &&
     strcmp(argv[1], "interpret_stm") == 0) {
    example = atoi(argv[2]);
    test_interpret(example);
  } else if(argc == 3 &&
     strcmp(argv[1], "id_in_stm") == 0) {
    example = atoi(argv[2]);
    test_ids(example);
  }
  else {
    fprintf(stderr, "invalid argument\n");
    exit(-1);
  }
}
