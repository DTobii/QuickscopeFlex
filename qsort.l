%{
#include "qsort.tab.h"
%}
%%
\- return bindestrich;
\: return doppelpunkt;
\= {sscanf(yytext,"%s",yylval.character);
                return gleich;
                };
\> {sscanf(yytext,"%s",yylval.character);
                return groesser;
                };
\< {sscanf(yytext,"%s",yylval.character);
                return kleiner;
                };
\>= {sscanf(yytext,"%s",yylval.character);
                return groessergleich;
                };
\<= {sscanf(yytext,"%s",yylval.character);
                return kleinergleich;
                };
\( return klammerauf;
\) return klammerzu;
\{ return eklammerauf;
\} return eklammerzu;
\, return komma;
\. return punkt;
\| return oder;
\n return aus;
\[\] {sscanf(yytext,"%s",yylval.character);
                return leereliste;
                }

[A-Z][a-zA-Z0-9]* {sscanf(yytext,"%s",yylval.character);
                return variable;
                }

[a-z][a-zA-Z0-9]* {sscanf(yytext,"%s",yylval.character);
                return term;
                }
\[[A-Z][a-zA-Z0-9]*\|[A-Z][a-zA-Z0-9]*\] {sscanf(yytext,"%s",yylval.character);
                return pipeliste;
                }

\[[A-Z][a-zA-Z0-9]*(\,[A-Z][A-Za-z0-9]*)*\] {sscanf(yytext,"%s",yylval.character);
                return kommaliste;
                }





