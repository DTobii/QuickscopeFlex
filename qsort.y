%{
#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
void yyerror(char *message);

  	typedef struct s_variablenlist
        {
                char variable[20];
                struct s_variablenlist *davor;
                struct s_variablenlist *danach;
        }variablenlist;

	typedef struct s_termlist
        {
                char term[10];
                struct s_variablenlist *varlist;
                struct s_termlist *davor;
                struct s_termlist *danach;
        }termlist;

        termlist *momtermlist;

void addVariable(char* vari) {
	strcpy(momtermlist->varlist->variable,vari);
	momtermlist->varlist->danach = (variablenlist*)malloc(sizeof(variablenlist));
	momtermlist->varlist->danach->davor = momtermlist->varlist;
	momtermlist->varlist = momtermlist->varlist->danach;
}

void nextTerm() {
	momtermlist->danach = (termlist*)malloc(sizeof(termlist));
	momtermlist->danach->davor = momtermlist;
	momtermlist = momtermlist->danach;
	momtermlist->varlist = (variablenlist*)malloc(sizeof(variablenlist));
	momtermlist->varlist->davor=0;
}

void setTerm(char* term) {
	strcpy(momtermlist->term,term);
}

void ausgabe() {
	while(momtermlist !=0 )  
    {
		while(momtermlist->varlist != 0)
        {
            printf("%s",momtermlist->varlist->variable);
			momtermlist->varlist=momtermlist->varlist->davor;
        }
		printf("%s",momtermlist->term);
		momtermlist=momtermlist->davor;
	}
}

%}

%start S

%union{
char character[100];
}

%token aus
%token bindestrich doppelpunkt gleich groesser kleiner groessergleich kleinergleich
%token klammerauf klammerzu eklammerauf eklammerzu
%token komma punkt oder 
%token leereliste variable term pipeliste kommaliste parameter

%type <character> term;
%type <character> variable;
%type <character> pipeliste;
%type <character> kommaliste;
%type <character> leereliste;
%type <character> gleich;
%type <character> kleiner;
%type <character> groessergleich;
%type <character> groesser;
%type <character> kleinergleich;

%%
S:  aus {
 printf("erkannt");
}
| Z 
| S Z | S aus {
}

Z: term { setTerm($1);} klammerauf A klammerzu C
   
A: leereliste {	addVariable($1);} B 
| pipeliste { addVariable($1);} B
| variable { addVariable($1);} B 

B: komma A | 

C: punkt aus { ausgabe();}
| doppelpunkt bindestrich D aus { ausgabe();}

D: G | variable {
	nextTerm();
	addVariable($1);
} E

E: kleiner variable 
{	
	setTerm($1);
	addVariable($2);
	
} F | groessergleich variable 
{	
	setTerm($1); 
	addVariable($2);
	
} F
F: komma {nextTerm();} Z 
G: term 
{
	nextTerm();
	setTerm($1);
} klammerauf A klammerzu H

H: punkt aus { ausgabe();}
| komma G

%%

int main(int argc, char **argv){
	momtermlist = (termlist*)malloc(sizeof(termlist));
	momtermlist->davor=0;
	momtermlist->varlist = (variablenlist*)malloc(sizeof(variablenlist));
	momtermlist->varlist->davor=0;
	yyparse();
	return 0;
}

void yyerror(char *message){
	printf("Good bye \n %s", message);
}
