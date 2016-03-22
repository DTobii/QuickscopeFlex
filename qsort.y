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
| conc klammerauf eklammerauf EB klammerzu komma L komma L klammerzu punkt
| conc klammerauf eklammerauf X oder R eklammerzu komma L komma eklammerauf X oder T eklammerzu klammerzu doppelpunkt bindestrich conc klammerauf R komma L komma T klammerzu punkt
| split klammerauf eklammerauf eklammerzu komma EB komma eklammerauf eklammerzu komma eklammerauf eklammerzu klammerzu punkt
| split klammerauf eklammerauf X oder R eklammerzu komma EB komma eklammerauf X oder K komma G klammerzu doppelpunkt bindestrich X kleiner EB komma split klammerauf R komma EB komma K komma G klammerzu punkt
| split klammerauf eklammerauf X oder R eklammerzu komma EB oder K oder eklammerauf X oder G eklammerzu klammerzu doppelpunkt bindestrich X groessergleich EB komma split klammerauf R komma EB komma K komma G klammerzu punkt
| qsort klammerauf eklammerauf eklammerzu komma eklammerauf eklammerzu klammerzu punkt
| qsort klammerauf eklammerauf EB oder R eklammerzu komma S klammerzu doppelpunkt bindestrich split klammerauf R komma EB komma K komma G klammerzu komma qsort klammerauf K komma SK klammerzu komma qsort klammerauf G komma SG klammerzu komma conc klammerauf SK komma eklammerauf EB oder SG eklammerzu komma S klammerzu punkt
| conc { printf("test");}

%%

int main(int argc, char **argv){
	yyparse();
	return 0;
}

void yyerror(char *message){
	printf("Good bu \n");
}
