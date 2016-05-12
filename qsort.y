%{
#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include <stdbool.h>
void yyerror(char *message);

  	
	typedef struct s_testlist
		{
				char variable[20];
				struct s_testlist *davor;
				struct s_testlist *danach;
		}testlist;

	typedef struct s_variablenlist
        {
                char variable[20];
                struct s_variablenlist *davor;
                struct s_variablenlist *danach;
        }variablenlist;

	typedef struct s_termlist
        {
                char term[20];
                struct s_variablenlist *varlist;
				struct s_variablenlist *firstvarlist;
                struct s_termlist *davor;
                struct s_termlist *danach;
        }termlist;

	typedef struct s_graphlist
        {
				int id;
                char typ[5];
				char eingang[100];
				char ausgang[100];
                struct s_graphlist *davor;
                struct s_graphlist *danach;
        }graphlist;

        termlist *momtermlist;
		termlist *firstmomterm;

		termlist *erstesElement;
		graphlist *momgraphlist;
		graphlist *firstgraphlist;
		testlist *itestlist;
		testlist *firstitestliste;

	int counter;
	int copies[50];
	int nextUpdate;
	int termCount;
	char iresult[100]="";
	char gresult[100]="";
	bool gresultbool;
	bool iresultbool;

void addITest(char* var){
	strcpy(itestlist->variable,var);
	itestlist->danach=(testlist*)malloc(sizeof(testlist));
	itestlist->danach->davor=itestlist;
	itestlist=itestlist->danach;
	itestlist->danach=0;
}

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

void nextGraph() {
	momgraphlist->danach = (graphlist*)malloc(sizeof(graphlist));
	momgraphlist->danach->davor = momgraphlist;
	momgraphlist = momgraphlist->danach;
	momgraphlist->danach=0;
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

void ausgabeAnalyse(){
	graphlist *dummy;

	dummy=firstgraphlist;
	while(dummy!=0){
		printf("%i %s %s %s\n", dummy->id, dummy->typ, dummy->ausgang, dummy->eingang);
		dummy=dummy->danach;
	}
}

void ausgabeTermlist(){
	termlist *dummy=firstmomterm;
	while(dummy->danach!=0)
	{
		printf("Term %s",dummy->term);
		while(dummy->varlist->danach!=0)
		{
			printf("Var %s",dummy->varlist->variable);
			dummy->varlist=dummy->varlist->danach;
		}
		printf("\n");
		dummy=dummy->danach;
	}
}

void testen(int c){
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
	savemomterm=firstmomterm;


//	ausgabeTermlist();

	//Liste für alle Variablen für den i test
	itestlist=(testlist*)malloc(sizeof(testlist));
	itestlist->davor=0;
	itestlist->danach=0;
	firstitestliste= itestlist;
	
	//an den Anfang gehen
	while(savemomterm->davor!=0)
	{
		savemomterm=savemomterm->davor;
	}
	
	//richtige Position
	while (k<=counter) {
		savemomterm=savemomterm->danach;
		printf("Counteri %i %i %s \n",k,counter,savemomterm->varlist->variable);
		k++;
	}
	//firstvarlist=savemomterm->varlist;
	printf("----- Position --- \n");
	printf("%s %s\n",savemomterm->davor->varlist->variable, savemomterm->davor->varlist->danach->variable);

	printf("Aktuelle Position %s %s \n\n", savemomterm->varlist->variable, savemomterm->varlist->danach->variable);

	printf("%s %s\n",savemomterm->danach->varlist->variable, savemomterm->danach->varlist->danach->variable);

	

	firstvartestlist = vartestlist;
	//Lade erste Variablenliste ein
	while (savemomterm->varlist->danach!=0){
		addITest(savemomterm->varlist->variable);		
		printf("Var eingelesen: %s\n",savemomterm->varlist->variable);
		strcpy(vartestlist->variable,savemomterm->varlist->variable);
		vartestlist->danach= (testlist*)malloc(sizeof(testlist));
		vartestlist->danach->davor = vartestlist;
		vartestlist = vartestlist->danach;
		vartestlist->danach=0;
		savemomterm->varlist=savemomterm->varlist->danach;		
	}

	variablenlist *aktuellvarlist=aktuellmomterm->varlist;
	//Lade zweite Variablenliste
	while(aktuellmomterm->varlist->danach!=0)
	{
		addITest(aktuellmomterm->varlist->variable);
		aktuellmomterm->varlist=aktuellmomterm->varlist->danach;
	}

	//Listen an die richtige Stelle setzen
	aktuellmomterm->varlist=aktuellvarlist;
	savemomterm->varlist=firstvarlist;
	vardummy = firstvartestlist;
	termdummy = firstmomterm;

	//gehe zweite Variablenliste durch und vergleiche diese mit der ersten
	while (aktuellmomterm->varlist->danach!=0 && gtest==true){
		vardummy = firstvartestlist;
		//Vergleiche direkt mit bisher gespeicherten Variablen und füge ggf. zu I oder G Test hinzu
		while(vardummy->danach!=0){
			printf(" Vergleich:%s=%s\n ", aktuellmomterm->varlist->variable, vardummy->variable);
					
			if(strcmp(aktuellmomterm->varlist->variable,vardummy->variable) == 0)
			{
				termdummy = firstmomterm;
				termdummy->varlist = firstmomterm->firstvarlist;
				while(termdummy->varlist->danach!=0)
				{
					//Für G Test
					if(strcmp(termdummy->varlist->variable,vardummy->variable) == 0){
						printf("G done\n");						
						sprintf(string,"%s %s",gresult,vardummy->variable);
						strcpy(gresult,string);

						//Lösche aus ITest list:
						itestlist= firstitestliste;
						while(itestlist->danach!=0)
						{
							if(strcmp(itestlist->variable,vardummy->variable) == 0)
							{
								if(itestlist->davor==0)
								{						
									itestlist->danach->davor=0;
									firstitestliste=itestlist->danach;
								}else if(itestlist->danach==0)
								{
									itestlist->davor->danach=0;
								}else{
									itestlist->davor->danach=itestlist->danach;
									itestlist->danach->davor=itestlist->davor;
								}
							}
							itestlist=itestlist->danach;
						}
						//lösche doppelte variable aus liste
						/*if(vardummy->davor==0)
						{						
							vardummy->danach->davor=0;
							firstvartestlist=vardummy->danach;
						}else if(vardummy->danach==0)
						{
							vardummy->davor->danach=0;
						}else{
							vardummy->davor->danach=vardummy->danach;
							vardummy->danach->davor=vardummy->davor;
						}
						
						if(aktuellmomterm->varlist->davor==0)
						{										
							firstvarlist=aktuellmomterm->varlist->danach;
							aktuellmomterm->firstvarlist=aktuellmomterm->varlist->danach;				
							aktuellmomterm->varlist->danach->davor=0;
							aktuellmomterm->varlist=aktuellmomterm->varlist->danach;
						}else if(aktuellmomterm->varlist->danach==0)
						{
							aktuellmomterm->varlist->davor->danach=0;
							aktuellmomterm->varlist=aktuellmomterm->varlist->davor;
							aktuellmomterm->firstvarlist=aktuellmomterm->varlist->davor;
						}else{
							aktuellmomterm->varlist->davor->danach=aktuellmomterm->varlist->danach;
							aktuellmomterm->varlist->danach->davor=aktuellmomterm->varlist->davor;
							aktuellmomterm->firstvarlist=aktuellmomterm->varlist->davor;
						}*/
						
						gtest=false;
						gresultbool=true;
					}
					//Schleife einen weiter
					termdummy->varlist=termdummy->varlist->danach;
				}//while
				//add i Test variable
			}//if	
			//Schleife einen weiter
			vardummy=vardummy->danach;		
		}//while vardummy	
		aktuellmomterm->varlist=aktuellmomterm->varlist->danach;
		vardummy=firstvartestlist;	
	}//while


	
/*	while(aktuellmomterm->varlist->danach!=0)
	{
		printf("Liste: %s\n",aktuellmomterm->varlist->variable);
		aktuellmomterm->varlist=aktuellmomterm->varlist->danach;
	} */

	//Listen an die richtige Position bewegen
	/*while(aktuellmomterm->varlist->davor!=0){
		aktuellmomterm->varlist=aktuellmomterm->varlist->davor;
	}

	while(vardummy->davor!=0){
		vardummy=vardummy->davor;
	}*/

	//ausgabe / i test
	/*while(vardummy->danach!=0){
		termdummy = firstmomterm;		
		termdummy->varlist = firstmomterm->firstvarlist;	
		while(termdummy->varlist->danach!=0)
		{					//Für I Test
			printf("(I-Vergleich: %s-%s \n", vardummy->variable, termdummy->varlist->variable);
									
			if(strcmp(termdummy->varlist->variable,vardummy->variable) == 0){
				printf("I Done\n");
				sprintf(string,"%s %s",iresult,vardummy->variable);
				iresultbool=true;
				strcpy(iresult,string);
			}
			termdummy->varlist=termdummy->varlist->danach;
		}
		vardummy=vardummy->danach;
	}	

	while(aktuellmomterm->varlist->danach!=0){
		termdummy = firstmomterm;		
		termdummy->varlist = firstmomterm->firstvarlist;	
		while(termdummy->varlist->danach!=0)
		{					//Für I Test
			printf("(I-Vergleich: %s-%s \n", aktuellmomterm->varlist->variable, termdummy->varlist->variable);
									
			if(strcmp(termdummy->varlist->variable,aktuellmomterm->varlist->variable) == 0){
				printf("I Done\n");
				sprintf(string,"%s %s",iresult,aktuellmomterm->varlist->variable);
				iresultbool=true;
				strcpy(iresult,string);
			}
			termdummy->varlist=termdummy->varlist->danach;
		}
		aktuellmomterm->varlist=aktuellmomterm->varlist->danach;
	}*/	
	itestlist=firstitestliste;
	while(itestlist->danach!=0){
		termdummy = firstmomterm;		
		termdummy->varlist = firstmomterm->firstvarlist;	
		while(termdummy->varlist->danach!=0)
		{					//Für I Test
			printf("(I-Vergleich: %s-%s \n", itestlist->variable, termdummy->varlist->variable);
									
			if(strcmp(termdummy->varlist->variable,itestlist->variable) == 0){
				printf("I Done\n");
				sprintf(string,"%s %s",iresult,itestlist->variable);
				iresultbool=true;
				strcpy(iresult,string);
			}
			termdummy->varlist=termdummy->varlist->danach;
		}
		itestlist=itestlist->danach;
	}

	aktuellmomterm = momtermlist;
	aktuellmomterm->varlist=firstvarlist;
	//savemomterm=firstmomterm;
	vardummy=firstvartestlist;
	gtest=true;
}

/*
bool gTest(int counter) {
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
	iresultbool=false;
	gresultbool=false;
	int i;
	vartestlist->davor=0;
	vartestlist->danach=0;
	
	strcpy(iresult,"");
	strcpy(gresult,"");

	aktuellmomterm = momtermlist;
	firstvarlist=momtermlist->varlist;
	savemomterm=firstmomterm;


	for (i=1;i<=counter;i++) {
		//printf("Savemomtermplus");		
		savemomterm=savemomterm->danach;
		//printf("  savemomterm var:  %s  ",savemomterm->varlist->variable);
	}

	firstvartestlist = vartestlist;

	
	//Lade erste Variablenliste ein
	while (savemomterm->varlist->danach!=0){
		//printf("Laden der vartestlist");
		strcpy(vartestlist->variable,savemomterm->varlist->variable);
		vartestlist->danach= (testlist*)malloc(sizeof(testlist));
		vartestlist->danach->davor = vartestlist;
		vartestlist = vartestlist->danach;
		vartestlist->danach=0;
		savemomterm->varlist=savemomterm->varlist->danach;
	}
	savemomterm->varlist=firstvarlist;
	vardummy = firstvartestlist;
	termdummy = firstmomterm;
	//gehe zweite Variablenliste durch und vergleiche diese mit der ersten
	while (aktuellmomterm->varlist->danach!=0){
		vardummy = firstvartestlist;
//		printf("Firstvarlist: %s",firstvartestlist->variable);
		//Vergleiche direkt mit bisher gespeicherten Variablen und füge ggf. zu I oder G Test hinzu
		while(vardummy->danach!=0){
			printf(" Vergleich:%s=%s\n ", aktuellmomterm->varlist->variable, vardummy->variable);
					
			if(strcmp(aktuellmomterm->varlist->variable,vardummy->variable) == 0)
			{
				termdummy = firstmomterm;
				termdummy->varlist = firstmomterm->firstvarlist;
//				printf("Variable %s",termdummy->varlist->variable);
				while(termdummy->varlist->danach!=0)
				{
					//Für G Test
					//printf("Compare %s %s", termdummy->varlist->variable, vardummy->variable);
					if(strcmp(termdummy->varlist->variable,vardummy->variable) == 0){
						printf("G done\n");						
						sprintf(string,"%s %s",gresult,vardummy->variable);
						strcpy(gresult,string);

						//lösche doppelte variable aus liste
						if(vardummy->davor==0)
						{						
							vardummy->danach->davor=0;
						}else if(vardummy->danach==0)
						{
							vardummy->davor->danach=0;
						}else{
							vardummy->davor->danach=vardummy->danach;
							vardummy->danach->davor=vardummy->davor;
						}

						gresultbool=true;
						itest=false;
					}
					//Schleife einen weiter
					termdummy->varlist=termdummy->varlist->danach;
				}
			}	
			//Schleife einen weiter
			vardummy=vardummy->danach;		
		}
		if(vardummy->danach == 0 && itest == true)
		{	
			termdummy = firstmomterm;		
			termdummy->varlist = firstmomterm->firstvarlist;	
			vardummy=vardummy->davor;
				//if(strcmp(aktuellmomterm->varlist->variable,vardummy->variable) == 0)
				//{
					while(termdummy->varlist->danach!=0)
					{					//Für I Test
						printf("(I-Vergleich: %s-%s \n", aktuellmomterm->varlist->variable, termdummy->varlist->variable);
									
						if(strcmp(termdummy->varlist->variable,aktuellmomterm->varlist->variable) == 0){
							printf("I Done\n");
							sprintf(string,"%s %s",iresult,aktuellmomterm->varlist->variable);
							iresultbool=true;
							strcpy(iresult,string);
						}
						termdummy->varlist=termdummy->varlist->danach;
					}
				//}

		}
		//i test für restliche liste
		if(itest==true)
		{
			while(vardummy!=0)
			{
				termdummy = firstmomterm;		
				termdummy->varlist = firstmomterm->firstvarlist;	
				
				while(termdummy->varlist->danach!=0)
					{					//Für I Test
						printf("(I-Vergleich: %s-%s \n", vardummy->variable, termdummy->varlist->variable);
									
						if(strcmp(termdummy->varlist->variable,vardummy->variable) == 0){
							printf("I Done\n");
							sprintf(string,"%s %s",iresult,vardummy->variable);
							iresultbool=true;
							strcpy(iresult,string);
						}
						termdummy->varlist=termdummy->varlist->danach;
					}
				vardummy=vardummy->davor;
			}
		}	
			
			
		itest=true;
		aktuellmomterm->varlist=aktuellmomterm->varlist->danach;
		vardummy=firstvartestlist;	
	}
	aktuellmomterm = momtermlist;
	aktuellmomterm->varlist=firstvarlist;
	savemomterm=firstmomterm;
	vardummy=firstvartestlist;
/*
	while (savemomterm->varlist->danach!=0){
		while (aktuellmomterm->varlist->danach!=0){	
			printf("VAR: %s:%s\n",aktuellmomterm->varlist->variable,savemomterm->varlist->variable);		
			if(strcmp(aktuellmomterm->varlist->variable,savemomterm->varlist->variable)==0)
			{
				printf("VAR: %s\n",aktuellmomterm->varlist->variable);
				if(re==false)
				{
					strcpy(gresult,aktuellmomterm->varlist->variable);
					re = true;	
				}else{
					sprintf(string,"%s,%s",gresult,aktuellmomterm->varlist->variable);
					strcpy(gresult,string);
				}
			}
			aktuellmomterm->varlist=aktuellmomterm->varlist->danach;
		}
		aktuellmomterm = momtermlist;
		aktuellmomterm->varlist=firstvarlist;
		savemomterm->varlist=savemomterm->varlist->danach;
	}


	return re;
}*/
/*
bool iTest() {
	bool re=false;
	char string[100];
	termlist *aktuellmomterm;
	termlist *savemomterm;
	variablenlist *firstvarlist;

	aktuellmomterm = momtermlist;
	firstvarlist=momtermlist->varlist;
	savemomterm=firstmomterm;

	while (savemomterm->varlist!=0){
		while (aktuellmomterm->varlist!=0){
			if(strcmp(aktuellmomterm->varlist->variable,savemomterm->varlist->variable)==0)
			{
				if(re==false)
				{
					strcpy(iresult,aktuellmomterm->varlist->variable);	
					re = true;
				}else{
					sprintf(string,"%s %s",iresult,aktuellmomterm->varlist->variable);
					strcpy(iresult,string);
				}
			}
			aktuellmomterm->varlist=aktuellmomterm->varlist->danach;
		}
		aktuellmomterm = momtermlist;
		aktuellmomterm->varlist = firstvarlist;
		savemomterm->varlist=savemomterm->varlist->danach;
	}
	
	return re;
}
*/


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
	setGraphIO(momtermlist->term,string);
	//ausgabeAnalyse();
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
		setGraphIO("-","-");
		updateOutputOfID(nextUpdate,2);
		nextUpdate=counter;
		//Update E
	//Testen ab 3. Element
	} else {
		// for schleife für ground test, von i=1 bis (<=) termCount
		//ausgabeAnalyse();
//		printf("Zahler: %i %i",i,termCount);
		for (i=1;i<=termCount;i++) {
			printf(" \n Aufruf mit %d \n ",i);
			testen(i);
			printf("  Result: %d %d  ", gresultbool, iresultbool);
			if (gresultbool==true) {
				//ausgabeAnalyse();
				//mach fancy shit
				if(iresultbool==true){
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
				}else{
					//nur G true
					nextGraph();
					setGraphVal("G",counter);
					sprintf(string,"(%i,2) (%i,1)",counter+1,counter+2);
					setGraphIO(gresult,string);
					nextGraph();
					setGraphVal("U",counter);
					sprintf(string,"(%i,1)",counter+1);
					setGraphIO("-",string);
				}
			}else{
				if(iresultbool==true){
					//nur i true
					nextGraph();
					setGraphVal("I",counter);
					sprintf(string,"(%i,2) (%i,1)", counter+2,counter+1);
					setGraphIO(iresult,string);
					nextGraph();
					setGraphVal("U",counter);
					sprintf(string,"(%i,1)",counter+1);
					setGraphIO("-",string);
				}else{
					//keins true
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
		if(momtermlist->danach!=0){
		setGraphVal("C",counter);
		sprintf(string,"(%i,1)",counter+1);
		setGraphIO("-",string);
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
		termCount=-1;
		while (momtermlist->danach!=0) {
			momtermlist=momtermlist->danach;
			//printf("\n --- While außen: %s %s \n",momtermlist->davor->varlist->variable, momtermlist->davor->varlist->danach->variable);
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
	if (momtermlist->davor==0){
	  //printf("%s",momtermlist->term);
	  while(momtermlist->varlist->davor!=0)
        {
            //printf("%s",momtermlist->varlist->variable);
			momtermlist->varlist=momtermlist->varlist->davor;
        }
		//printf("%s",momtermlist->varlist->variable);
	} else {
		while(momtermlist->davor!=0)
    	{
			//printf("%s",momtermlist->term);
			while(momtermlist->varlist->davor!=0)
        	{
            	//printf("%s",momtermlist->varlist->variable);
				momtermlist->varlist=momtermlist->varlist->davor;
        	}
			//printf("%s",momtermlist->varlist->variable);
			momtermlist->varlist=momtermlist->firstvarlist;
			momtermlist=momtermlist->davor;
		}
		//printf("%s",momtermlist->term);
		while(momtermlist->varlist->davor!=0)
        	{
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

void yyerror(char *message){
	printf("Good bye \n %s", message);
}
