
/* Simple linked list implementation for a key-value table
 */
struct _entry {
  char *key;
  int value;
  struct _entry *next;
};

typedef struct _entry Entry;

typedef Entry *Table;

extern int lookup_value(Table, char *);
extern Entry *lookup(Table, char *);
extern Table add_entry(Table, char *, int);
extern void update_value(Entry *, int);
