%{
#include "qsort.tab.h"
%}
%%
\- return bindestrich;
\: return doppelpunkt;
\= return gleich;
\> return groesser;
\< return kleiner;
\>= return groessergleich;
\( return klammerauf;
\) return klammerzu;
\{ return eklammerauf;
\} return eklammerzu;
\, return komma;
\. return punkt;
\| return oder;
\n return aus;
\[\] return leereliste;
[A-Z][a-zA-Z0-9]* return variable;
[a-z][a-zA-Z0-9]* return term;
\[[A-Z][a-zA-Z0-9]*\|[A-Z][a-zA-Z0-9]*\] return pipeliste;
\[[A-Z][a-zA-Z0-9]*(\,[A-Z][A-Za-z0-9]*)*\] return kommaliste;




