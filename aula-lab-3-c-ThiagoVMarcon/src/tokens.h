/* NOTA:
   como vamos apenas reconhecer expressões bem-formadas 
   não necessitamos de associar um valor ao *token* NUM 
*/

typedef enum { PLUS,
               MINUS,
               MULT,
               DIV,
               LPAREN,
               RPAREN,
               NUM,
               END_OF_FILE } Token;

extern void consume(Token);
extern void advance(void);
extern Token yylex(void);

