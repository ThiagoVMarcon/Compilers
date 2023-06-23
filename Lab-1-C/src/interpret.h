
extern int id_in_exp(Exp, char *);
extern int id_in_stm(Stm, char *);

extern int interpret_exp(Exp , Table);
extern Table interpret_stm(Stm, Table);
