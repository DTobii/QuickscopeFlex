void addVariable(char* vari);
void nextTerm();
void setTerm(char* term);


typedef struct s_variablenlist {
    char variable[20];
    struct s_variablenlist *davor;
    struct s_variablenlist *danach;
} variablenlist;

typedef struct s_termlist {
    char term[20];
    struct s_variablenlist *varlist;
    struct s_variablenlist *firstvarlist;
    struct s_termlist *davor;
    struct s_termlist *danach;
} termlist;


termlist *momtermlist;
termlist *firstmomterm;
termlist *erstesElement;


void addVariable(char* vari) {
    strcpy(momtermlist->varlist->variable,vari);
    momtermlist->varlist->danach = (variablenlist*)malloc(sizeof(variablenlist));
    momtermlist->varlist->danach->davor = momtermlist->varlist;
    momtermlist->varlist = momtermlist->varlist->danach;
    momtermlist->varlist->danach=0;
}

void nextTerm() {
    momtermlist->danach = (termlist*)malloc(sizeof(termlist));
    momtermlist->danach->davor = momtermlist;
    momtermlist = momtermlist->danach;
    momtermlist->danach = 0;
    momtermlist->varlist = (variablenlist*)malloc(sizeof(variablenlist));
    momtermlist->firstvarlist = momtermlist->varlist;
    momtermlist->varlist->davor=0;
    momtermlist->varlist->danach=0;
}

void setTerm(char* term) {
    strcpy(momtermlist->term,term);
}
