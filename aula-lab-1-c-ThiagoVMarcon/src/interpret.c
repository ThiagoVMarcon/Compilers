/* Interpreter for straight-line programs
 * Pedro Vasconcelos, 2022
 */

#include "ast.h"
#include "table.h"
#include "interpret.h"
#include <stdlib.h>
#include <stdio.h>

/* Test if an identifier occurs in an expression; returns 0/1
 */
int id_in_exp(Exp exp, char *id) {
  // complete
}

/* Test if an indentifier occurs in a statement; return 0/1
 */
int id_in_stm(Stm stm, char *id) {
  // complete
}


/*  Interpreter for expressions
 */
int interpret_exp(Exp exp, Table tbl) {
  // complete
}

/* Interpreter for statements
 */
Table interpret_stm(Stm stm, Table tbl) {
  // complete
}
