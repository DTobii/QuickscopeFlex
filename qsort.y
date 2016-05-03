%{
#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include <stdbool.h>
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

	typedef struct s_graphlist
        {
				int id;
                char typ[5];
				char eingang[50];
				char ausgang[50];
                struct s_graphlist *davor;
                struct s_graphlist *danach;
        }graphlist;

        termlist *momtermlist;
		termlist *firstmomterm;
		graphlist *momgraphlist;
		graphlist *firstgraphlist;

	int counter;
	int copies[50];
	int nextUpdate;
	int termCount;
	char iresult[50];
	char gresult[50];

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

void nextGraph() {
	momgraphlist->danach = (graphlist*)malloc(sizeof(graphlist));
	momgraphlist->danach->davor = momgraphlist;
	momgraphlist = momgraphlist->danach;
	counter++;
}

void setGraphVal(char* typ,int id) {
	strcpy(momgraphlist->typ,typ);
	momgraphlist->id=id;
}

void setGraphIO(char* input,char* output) {
	strcpy(momgraphlist->eingang,input);
	strcpy(momgraphlist->ausgang,output);
}


bool gTest(int counter) {
	bool re = false;	
	termlist *aktuellmomterm;
	termlist *savemomterm;
	aktuellmomterm = momtermlist;
	momtermlist=firstmomterm;
	for (int i=1;i<=counter;i++) {
		momtermlist=momtermlist->danach;
	}
	while (momtermlist->varlist->danach!=0){
		while (aktuellmomterm->varlist->danach!=0){
			if(aktuellmomterm->varlist->variable == momtermlist->varlist->variable)
			{
				if(re==false)
				{
					strcpy(gresult,aktuellmomterm->varlist->variable);
					re = true;	
				}else{
					strcat(gresult,aktuellmomterm->varlist->variable);
				}
			}
			aktuellmomterm->varlist=aktuellmomterm->varlist->danach;
		}
		momtermlist->varlist=momtermlist->varlist->danach;
	}
	//Variablenliste zurücl
	while (momtermlist->varlist->davor!=0){
		momtermlist->varlist = momtermlist->varlist->davor;
	}

	while  (aktuellmomterm->varlist->davor!=0){
		aktuellmomterm->varlist = aktuellmomterm->varlist->davor;
	}
	momtermlist=aktuellmomterm;
	return re;
}

bool iTest() {
	bool re=false;
	termlist *aktuellmomterm;
	termlist *savemomterm;	
	aktuellmomterm = momtermlist;
	momtermlist=firstmomterm;
	while (momtermlist->varlist->danach!=0){
		while (aktuellmomterm->varlist->danach!=0){
			if(aktuellmomterm->varlist->variable == momtermlist->varlist->variable)
			{
				if(re==false)
				{
					strcpy(iresult,aktuellmomterm->varlist->variable);	
					re = true;
				}else{
					strcat(iresult,aktuellmomterm->varlist->variable);
				}
			}
			aktuellmomterm->varlist=aktuellmomterm->varlist->danach;
		}
		momtermlist->varlist=momtermlist->varlist->danach;
	}
	//Variablenliste zurücl
	while (momtermlist->varlist->davor!=0){
		momtermlist->varlist = momtermlist->varlist->davor;
	}

	while  (aktuellmomterm->varlist->davor!=0){
		aktuellmomterm->varlist = aktuellmomterm->varlist->davor;
	}
	momtermlist=aktuellmomterm;
	return re;
}

void ausgabeAnalyse(){
	while(firstgraphlist->danach!=0){
		printf("%i %s %s %s\n", firstgraphlist->id, firstgraphlist->typ, firstgraphlist->ausgang, firstgraphlist->eingang);
		firstgraphlist= firstgraphlist->danach;
	}
}

void analyseTerm() {
	char string[50];
	sprintf(string,"(%i,1)",counter+1);
	setGraphVal("U",counter);
	setGraphIO(momtermlist->term,string);
	//Testen ob 2. Element
	if (momtermlist->davor->davor==0) {
		nextGraph();
		setGraphVal("A",counter);
		sprintf(string,"(%i,1)",counter+1);
		setGraphIO("-",string);
		nextGraph();
		setGraphVal("C",counter);
		sprintf(string,"(%i,1)",counter+1);
		setGraphIO("-",string);
		//Save in array
		nextGraph();
		setGraphVal("U",counter);
		sprintf(string,"(%i,1)",counter+1);
		setGraphIO("-",string);
		//Update E
	//Testen ab 3. Element
	} else {
		// for schleife für ground test, von i=1 bis (<=) termCount
		for (int i=1;i<=termCount;i++) {
			if (gTest(i)==true) {
				//mach fancy shit
				if(iTest()==true){
					//beide Tests true
					nextGraph();
					setGraphVal("G",counter);
					sprintf(string,"(%i,2), (%i,1)",counter+2,counter+1);
					setGraphIO(gresult,string);
					nextGraph();
					setGraphVal("I",counter);
					sprintf(string,"(%i,2), (%i,1⁾)", counter+1,counter+2);
					setGraphIO(iresult,string);
					nextGraph();
					setGraphVal("U",counter);
					sprintf(string,"(%i,1)",counter+1);
					setGraphIO("-",string);
				}else{
					//nur G true
					nextGraph();
					setGraphVal("G",counter);
					sprintf(string,"(%i,2), (%i,1)",counter+1,counter+2);
					setGraphIO(gresult,string);
					nextGraph();
					setGraphVal("U",counter);
					sprintf(string,"(%i,1)",counter+1);
					setGraphIO("-",string);
				}
			}else{
				if(iTest()==true){
					//nur i true
					nextGraph();
					setGraphVal("I",counter);
					sprintf(string,"(%i,2), (%i,1⁾)", counter+2,counter+1);
					setGraphIO(iresult,string);
					nextGraph();
					setGraphVal("U",counter);
					sprintf(string,"(%i,1)",counter+1);
					setGraphIO("-",string);
				}else{
					//keins true
				}
			}			
		}
		//Testsende
		nextGraph();
		setGraphVal("A",counter);
		sprintf(string,"(%i,1)",counter+1);
		setGraphIO("-",string);
		nextGraph();
		setGraphVal("C",counter);
		sprintf(string,"(%i,1)",counter+1);
		setGraphIO("-",string);
	}
}


void analyse() {
	if (momtermlist->danach==0) {
		setGraphVal("E",counter);
		setGraphIO("-","(2,1)");
		nextGraph();
		setGraphVal("R",counter);
		setGraphIO("-","-");
	} else {
		setGraphVal("E",counter);
		strcpy(momgraphlist->eingang,momtermlist->term);
		nextUpdate=counter;
		nextGraph();
		setGraphVal("C",counter);
		termCount=-1;
		while (momtermlist->danach!=0) {
			momtermlist=momtermlist->danach;
			termCount++;
			nextGraph();
			analyseTerm();
		}
	}
	//Ausgabe hier
	ausgabeAnalyse();
}

void ausgabe() {
	counter=1;
	while(momtermlist !=0 )  
    {
		while(momtermlist->varlist != 0)
        {
            //printf("%s",momtermlist->varlist->variable);
			momtermlist->varlist=momtermlist->varlist->davor;
        }
		//printf("%s",momtermlist->term);
		if (momtermlist->davor!=0){
			momtermlist=momtermlist->davor;
		} else {
			break;
		}
	}
	momgraphlist = (graphlist*)malloc(sizeof(graphlist));
	momgraphlist->davor=0;
	firstgraphlist = momgraphlist;
	analyse();
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
	firstmomterm =momtermlist;
	momtermlist->davor=0;
	momtermlist->varlist = (variablenlist*)malloc(sizeof(variablenlist));
	momtermlist->varlist->davor=0;
	yyparse();
	return 0;
}

void yyerror(char *message){
	printf("Good bye \n %s", message);
}
