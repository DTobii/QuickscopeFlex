%{
#include <stdio.h>
#include <string.h>
#include <math.h>
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

%}

%start S

%union{
char character[100];
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
| S Z | S aus {
}

Z: term {
	strcpy(momtermlist->term,$1);
	momtermlist->danach = (termlist*)malloc(sizeof(termlist));
	momtermlist->danach->davor = momtermlist;
	momtermlist = momtermlist->danach;
	momtermlist->varlist = (variablenlist*)malloc(sizeof(variablenlist));
	momtermlist->varlist->davor=0;
} klammerauf A klammerzu C
   
A: leereliste 
{	
	strcpy(momtermlist->varlist->variable,$1);
	momtermlist->varlist->danach = (variablenlist*)malloc(sizeof(variablenlist));
	momtermlist->varlist->danach->davor = momtermlist->varlist;
	momtermlist->varlist = momtermlist->varlist->danach;
} B | pipeliste 
{
	strcpy(momtermlist->varlist->variable,$1);
	momtermlist->varlist->danach = (variablenlist*)malloc(sizeof(variablenlist));
	momtermlist->varlist->danach->davor = momtermlist->varlist;
	momtermlist->varlist = momtermlist->varlist->danach;
}
B | variable 
{
	strcpy(momtermlist->varlist->variable,$1);
	momtermlist->varlist->danach = (variablenlist*)malloc(sizeof(variablenlist));
	momtermlist->varlist->danach->davor = momtermlist->varlist;
	momtermlist->varlist = momtermlist->varlist->danach;
}
B 

B: komma A | 
C: punkt aus 
{
	while(momtermlist->davor !=0 )  
       	{
		while(momtermlist->varlist->davor != 0)
        	{
                        momtermlist->varlist=momtermlist->varlist->davor;
                        printf("%s",momtermlist->varlist->variable);
                }
        momtermlist= momtermlist->davor;
	printf("%s",momtermlist->term);
	}
}
 | doppelpunkt bindestrich D aus 
{
	while(momtermlist->davor!= 0)
       	{
		while(momtermlist->varlist->davor != 0)
                {
                        momtermlist->varlist=momtermlist->varlist->davor;
                        printf("%s",momtermlist->varlist->variable);
                } 
	        momtermlist= momtermlist->davor;
        	printf("%s",momtermlist->term);
        }
}
D: G | variable E
E: kleiner variable F | groessergleich variable F
F: komma Z 
G: term 
{
	strcpy(momtermlist->term,$1); 
	momtermlist->danach = (termlist*)malloc(sizeof(termlist));
	momtermlist->danach->davor = momtermlist;
	momtermlist = momtermlist->danach;
	momtermlist->varlist = (variablenlist*)malloc(sizeof(variablenlist));
        momtermlist->varlist->davor=0;
} klammerauf A klammerzu H

H: punkt aus
{
	while(momtermlist->davor!= 0)  
      	{
		while(momtermlist->varlist->davor != 0)
	        {
		        momtermlist->varlist=momtermlist->varlist->davor;
	                printf("%s",momtermlist->varlist->variable);
	        } 
        momtermlist= momtermlist->davor;
       	printf("%s",momtermlist->term);
	}
}
 | komma G  

%%

int main(int argc, char **argv){
	momtermlist = (termlist*)malloc(sizeof(termlist));
	momtermlist->davor=0;	
	yyparse();
	return 0;
}

void yyerror(char *message){
	printf("Good bye \n %s", message);
}
