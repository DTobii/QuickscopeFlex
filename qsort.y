%{
#include <stdio.h>
#include <math.h>
void yyerror(char *message);
%}

%start S

%union{
char* character;
}

%token aus
%token bindestrich doppelpunkt gleich groesser kleiner groessergleich
%token klammerauf klammerzu eklammerauf eklammerzu
%token komma punkt oder 
%token leereliste variable term pipeliste kommaliste parameter

%type <character> term;
%type <character> variable;
%type <character> pipeliste;
%type <character> kommaliste;
%type <character> leereliste;

%%
S:  aus {
printf("erkannt");
}
| Z 
| S Z | S aus {printf("erkannt");}

Z: term klammerauf A klammerzu C 
   
A: leereliste B | pipeliste B | variable B 
B: komma A | 
C: punkt aus | doppelpunkt bindestrich D aus
D: G | variable E
E: kleiner variable F | groessergleich variable F
F: komma Z 
G: term klammerauf A klammerzu H
H: punkt aus | komma G  

%%

int main(int argc, char **argv){
	yyparse();
	return 0;
}

void yyerror(char *message){
	printf("Good bye \n %s", message);
}
