%{
#include "qsort.tab.h"
%}
%%
[S] return SB;
[L] return L;
[X] return X;
[R] return R;
[E] return EB;
[G] return G;
[T] return T;
[K] return K;
[S][K] return SK;
[S][G] return SG;
\- return bindestrich;
\: return doppelpunkt;
\= return gleich;
\> return groesser;
\< return kleiner;
\>= return groessergleich;
[c][o][n][c] return conc;
[s][p][l][i][t] return split;
[q][s][o][r][t] return qsort;
\( return klammerauf;
\) return klammerzu;
\{ return eklammerauf;
\} return eklammerzu;
\, return komma;
\. return punkt;
\| return oder;
\n return aus;




