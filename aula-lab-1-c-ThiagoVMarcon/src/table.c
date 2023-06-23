/* Simple key-value table implemented as a linked list
 * Pedro Vasconcelos, 2022
 */

#include "table.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

/* Lookup a name in a table; returns entry or NULL if it doesn't occur
 */
Entry *lookup(Table tbl, char *name) {
  while (tbl != NULL) {
    if(strcmp(tbl->key, name) == 0) 
      return tbl;
    tbl = tbl->next;
  }
  return NULL;
}

/*
 * Lookup a name in table; return a value or exits with error
 */
int lookup_value(Table tbl, char *name) {
  Entry *ptr = lookup(tbl, name);
  if(ptr == NULL) {
    fprintf(stderr, "unknown name: %s\n", name);
    exit(-1);
  }
  return ptr->value;
}


/* Update the value in an entry
 */
void update_value(Entry *ptr, int new_value) {
  ptr->value = new_value;
}

/* Add an entry to the begining of a table
 */
Table add_entry(Table tbl, char *name, int value) {
  Entry *ptr = malloc(sizeof(Entry));
  ptr->key = name;
  ptr->value = value;
  ptr->next = tbl;
  return ptr;
}

