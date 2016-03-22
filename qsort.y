%{
#include <stdio.h>
#include <math.h>
void yyerror(char *message);
int fehler=0;
%}

%start S

%token SB L X R EB G T K SK SG aus
%token bindestrich doppelpunkt gleich groesser kleiner groessergleich
%token conc split qsort klammerauf klammerzu eklammerauf eklammerzu
%token komma punkt oder 

%%
S:  aus {
printf("= erkannt");

}
| conc { printf("test");}

%%

int main(int argc, char **argv){
	yyparse();
	return 0;
}

void yyerror(char *message){
	printf("Good bu \n");
}
