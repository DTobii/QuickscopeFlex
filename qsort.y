%{
#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include <stdbool.h>

#include "termlist.h"
#include "graphlist.h"

void yyerror(char *message);

typedef struct s_testlist {
    char variable[20];
    struct s_testlist *davor;
    struct s_testlist *danach;
} testlist;

testlist *itestlist;
testlist *firstitestliste;


int copies[50];
int nextUpdate;
int termCount;

//array and counter for all cs
int ccounter=1;
int cpositions[100];
char iresult[100]="";
char gresult[100]="";
bool gresultbool;
bool iresultbool;

void addITest(char* var) {
    strcpy(itestlist->variable,var);
    itestlist->danach=(testlist*)malloc(sizeof(testlist));
    itestlist->danach->davor=itestlist;
    itestlist=itestlist->danach;
    itestlist->danach=0;
}

void ausgabeAnalyse() {
    graphlist *dummy;

    dummy=firstgraphlist;
    while(dummy!=0) {
        printf("%i %s %s %s\n", dummy->id, dummy->typ, dummy->ausgang, dummy->eingang);
        dummy=dummy->danach;
    }
}

void ausgabeTermlist() {
    termlist *dummy=firstmomterm;
    while(dummy->danach!=0) {
        printf("Term %s",dummy->term);
        while(dummy->varlist->danach!=0) {
            printf("Var %s",dummy->varlist->variable);
            dummy->varlist=dummy->varlist->danach;
        }
        printf("\n");
        dummy=dummy->danach;
    }
}

void testen(int c) {
    int counter = c;
    bool re = false;
    char string[100];
    termlist *aktuellmomterm;
    termlist *savemomterm;
    variablenlist *firstvarlist;

    testlist *vartestlist = (testlist*)malloc(sizeof(testlist));
    testlist *firstvartestlist;
    testlist *vardummy = (testlist*)malloc(sizeof(testlist));;
    termlist *termdummy;
    bool itest=true;
    bool gtest=true;
    iresultbool=false;
    gresultbool=false;
    int k=1;
    vartestlist->davor=0;
    vartestlist->danach=0;

    strcpy(iresult,"");
    strcpy(gresult,"");

    aktuellmomterm = momtermlist;
    firstvarlist=momtermlist->varlist;
    savemomterm=momtermlist;

    //ausgabeTermlist();

    //Liste für alle Variablen für den i test
    itestlist=(testlist*)malloc(sizeof(testlist));
    itestlist->davor=0;
    itestlist->danach=0;
    firstitestliste= itestlist;

    //an den Anfang gehen
    while(savemomterm->davor!=0) {
        savemomterm=savemomterm->davor;
    }

    //richtige Position
    while (k<=counter) {
        savemomterm=savemomterm->danach;
        k++;
    }

    firstvartestlist = vartestlist;
    //Lade erste Variablenliste ein
    while (savemomterm->varlist->danach!=0) {
        addITest(savemomterm->varlist->variable);
        strcpy(vartestlist->variable,savemomterm->varlist->variable);
        vartestlist->danach= (testlist*)malloc(sizeof(testlist));
        vartestlist->danach->davor = vartestlist;
        vartestlist = vartestlist->danach;
        vartestlist->danach=0;
        savemomterm->varlist=savemomterm->varlist->danach;
    }

    variablenlist *aktuellvarlist=aktuellmomterm->varlist;
    //Lade zweite Variablenliste
    while(aktuellmomterm->varlist->danach!=0) {
        addITest(aktuellmomterm->varlist->variable);
        aktuellmomterm->varlist=aktuellmomterm->varlist->danach;
    }

    //Listen an die richtige Stelle setzen
    aktuellmomterm->varlist=aktuellvarlist;

    while(savemomterm->varlist->davor!=0) {
        savemomterm->varlist=savemomterm->varlist->davor;
    }

    vardummy = firstvartestlist;
    termdummy = firstmomterm;

    //gehe zweite Variablenliste durch und vergleiche diese mit der ersten
    while (aktuellmomterm->varlist->danach!=0 && gtest==true) {
        vardummy = firstvartestlist;
        //Vergleiche direkt mit bisher gespeicherten Variablen und füge ggf. zu I oder G Test hinzu
        while(vardummy->danach!=0) {

            if(strcmp(aktuellmomterm->varlist->variable,vardummy->variable) == 0) {
                termdummy = firstmomterm;
                termdummy->varlist = firstmomterm->firstvarlist;
                while(termdummy->varlist->danach!=0) {
                    //Für G Test
                    if(strcmp(termdummy->varlist->variable,vardummy->variable) == 0) {
                        sprintf(string,"%s %s",gresult,vardummy->variable);
                        strcpy(gresult,string);

                        //Lösche aus ITest list:
                        itestlist= firstitestliste;
                        while(itestlist->danach!=0) {
                            if(strcmp(itestlist->variable,vardummy->variable) == 0) {
                                if(itestlist->davor==0) {
                                    itestlist->danach->davor=0;
                                    firstitestliste=itestlist->danach;
                                } else if(itestlist->danach==0) {
                                    itestlist->davor->danach=0;
                                } else {
                                    itestlist->davor->danach=itestlist->danach;
                                    itestlist->danach->davor=itestlist->davor;
                                }
                            }
                            itestlist=itestlist->danach;
                        }

                        gtest=false;
                        gresultbool=true;
                    }
                    //Schleife einen weiter
                    termdummy->varlist=termdummy->varlist->danach;
                }//while

            }//if
            //Schleife einen weiter
            vardummy=vardummy->danach;
        }//while vardummy
        aktuellmomterm->varlist=aktuellmomterm->varlist->danach;
        vardummy=firstvartestlist;
    }//while

    //Überprüfe I Test
    itestlist=firstitestliste;
    while(itestlist->danach!=0) {
        termdummy = firstmomterm;
        termdummy->varlist = firstmomterm->firstvarlist;
        while(termdummy->varlist->danach!=0) {
            if(strcmp(termdummy->varlist->variable,itestlist->variable) == 0) {
                sprintf(string,"%s %s",iresult,itestlist->variable);
                iresultbool=true;
                strcpy(iresult,string);
            }
            termdummy->varlist=termdummy->varlist->danach;
        }
        itestlist=itestlist->danach;
    }

    aktuellmomterm->varlist=firstvarlist;
    vardummy=firstvartestlist;
    gtest=true;
}

void updateOutputOfID(int id,int eingang) {
    graphlist *dummy;
    char string[100];

    dummy=firstgraphlist;

    while (dummy->id!=id) {
        dummy=dummy->danach;
    }
    sprintf(string,"%s (%d,%d)",dummy->ausgang, counter, eingang);
    strcpy(dummy->ausgang,string);
}

void analyseTerm() {
    char string[50];
    int i=1;
    int j=1;
    sprintf(string,"(%i,1)",counter+1);
    setGraphVal("U",counter);
    updateOutputOfID(cpositions[1], 1);
    setGraphIO(momtermlist->term,string);
    //Testen ob 2. Element
    if (momtermlist->davor->davor==0) {
        nextGraph();
        setGraphVal("A",counter);
        sprintf(string,"(%i,1)",counter+1);
        setGraphIO("-",string);
        nextGraph();
        setGraphVal("C",counter);
        cpositions[ccounter]=counter;
        ccounter++;
        sprintf(string,"(%i,1)",counter+1);
        setGraphIO("",string);
        nextGraph();
        setGraphVal("U",counter);
        setGraphIO("-","");
        updateOutputOfID(nextUpdate,2);
        nextUpdate=counter;
        //Update E
        //Testen ab 3. Element
    } else {
        // for schleife für ground test, von i=1 bis (<=) termCount

        for (i=1; i<=termCount; i++) {
            testen(i);
            if (gresultbool==true) {
                //mach fancy shit
                if(iresultbool==true) {
                    //beide Tests true
                    nextGraph();
                    setGraphVal("G",counter);
                    sprintf(string,"(%i,2) (%i,1)",counter+2,counter+1);
                    setGraphIO(gresult,string);
                    nextGraph();
                    setGraphVal("I",counter);
                    sprintf(string,"(%i,2) (%i,1)", counter+1,counter+2);
                    setGraphIO(iresult,string);
                    nextGraph();
                    setGraphVal("U",counter);
                    sprintf(string,"(%i,1)",counter+1);
                    setGraphIO("-",string);
                    updateOutputOfID(cpositions[i+1],1);
                } else {
                    //nur G true
                    nextGraph();
                    setGraphVal("G",counter);
                    sprintf(string,"(%i,2) (%i,1)",counter+1,counter+2);
                    setGraphIO(gresult,string);
                    nextGraph();
                    setGraphVal("U",counter);
                    sprintf(string,"(%i,1)",counter+1);
                    setGraphIO("-",string);
                    updateOutputOfID(cpositions[i+1],1);
                }
            } else {
                if(iresultbool==true) {
                    //nur i true
                    nextGraph();
                    setGraphVal("I",counter);
                    sprintf(string,"(%i,2) (%i,1)", counter+2,counter+1);
                    setGraphIO(iresult,string);
                    nextGraph();
                    setGraphVal("U",counter);
                    sprintf(string,"(%i,1)",counter+1);
                    setGraphIO("-",string);
                    updateOutputOfID(cpositions[i+1],1);
                } else {
                    //keins true -> normale Bauminhalte kommen nach dem IF, kann leer bleiben
                }
            }//for schleife
        }
        //Testsende
        nextGraph();
        setGraphVal("A",counter);
        sprintf(string,"(%i,1)",counter+1);
        setGraphIO("-",string);
        nextGraph();
        //am Ende des letzten Terms/baums darf kein C erscheinen
        if(momtermlist->danach!=0) {
            setGraphVal("C",counter);
            cpositions[ccounter]=counter;
            ccounter++;
            sprintf(string,"(%i,1)",counter+1);
            setGraphIO("",string);
            nextGraph();
        }
        setGraphVal("U",counter);
        setGraphIO("-","");
        updateOutputOfID(nextUpdate,2);
        //Update E TODO
        nextUpdate=counter;
    }
}


void analyse() {
    char string[100];
    if (momtermlist->danach==0) {
        setGraphVal("E",counter);
        setGraphIO("-","(2,1)");
        nextGraph();
        setGraphVal("R",counter);
        setGraphIO("-","-");
    } else {
        setGraphVal("E",counter);
        setGraphIO(momtermlist->term,"(2,1)");
        nextUpdate=counter;
        nextGraph();
        setGraphVal("C",counter);
        cpositions[ccounter]=counter;
        ccounter++;
        termCount=-1;
        while (momtermlist->danach!=0) {
            momtermlist=momtermlist->danach;
            termCount++;
            nextGraph();
            analyseTerm();
        }
        //Insert Value of the last U
        sprintf(string,"(%i,1)",counter+1);
        setGraphIO("",string);
        nextGraph();
        setGraphVal("R",counter);
        setGraphIO("-","-");
    }
    //Ausgabe hier
    ausgabeAnalyse();
}

void ausgabe() {
    counter=1;
    if (momtermlist->davor==0) {
        //printf("%s",momtermlist->term);
        while(momtermlist->varlist->davor!=0) {
            //printf("%s",momtermlist->varlist->variable);
            momtermlist->varlist=momtermlist->varlist->davor;
        }
        //printf("%s",momtermlist->varlist->variable);
    } else {
        while(momtermlist->davor!=0) {
            //printf("%s",momtermlist->term);
            while(momtermlist->varlist->davor!=0) {
                //printf("%s",momtermlist->varlist->variable);
                momtermlist->varlist=momtermlist->varlist->davor;
            }
            //printf("%s",momtermlist->varlist->variable);
            momtermlist->varlist=momtermlist->firstvarlist;
            momtermlist=momtermlist->davor;
        }
        //printf("%s",momtermlist->term);
        while(momtermlist->varlist->davor!=0) {
            //printf("%s",momtermlist->varlist->variable);
            momtermlist->varlist=momtermlist->varlist->davor;
        }
        //printf("%s",momtermlist->varlist->variable);
    }

    momgraphlist = (graphlist*)malloc(sizeof(graphlist));
    momgraphlist->davor=0;
    firstgraphlist = momgraphlist;
    momtermlist =firstmomterm;
    momtermlist->varlist=momtermlist->firstvarlist;
    analyse();
}

%}

%start S

%union {
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
S:
aus {
    printf("erkannt");
}
| Z
| S Z | S aus {
}

Z:
term { setTerm($1);} klammerauf A klammerzu C

A:
leereliste {	addVariable($1);} B
| pipeliste { addVariable($1);} B
| variable { addVariable($1);} B

B:
komma A |

C:
punkt aus { ausgabe();}
| doppelpunkt bindestrich D aus { ausgabe();}

D:
G | variable {
    nextTerm();
    addVariable($1);
} E

E:
kleiner variable {
    setTerm($1);
    addVariable($2);

} F | groessergleich variable {
    setTerm($1);
    addVariable($2);

} F
F:
komma {nextTerm();} Z
G:
term {
    nextTerm();
    setTerm($1);
} klammerauf A klammerzu H

H:
punkt aus { ausgabe();}
| komma G

%%

int main(int argc, char **argv) {
    momtermlist = (termlist*)malloc(sizeof(termlist));
    firstmomterm =momtermlist;
    erstesElement = momtermlist;
    momtermlist->davor = 0;
    momtermlist->danach = 0;
    momtermlist->varlist = (variablenlist*)malloc(sizeof(variablenlist));
    momtermlist->firstvarlist = momtermlist->varlist;
    momtermlist->varlist->davor=0;
    momtermlist->varlist->danach=0;
    yyparse();
    return 0;
}

void yyerror(char *message) {
    printf("Good bye \n %s", message);
}
