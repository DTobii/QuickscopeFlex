#/bin/bash

bison qsort.y -d
flex qsort.l
gcc -o qsort qsort.tab.c lex.yy.c -lfl 2>/dev/null
rm lex.yy.c qsort.tab.c qsort.tab.h

echo "Testing 1 of 7 Inputs" $(printf "conc([],L,L).\n\n" | ./qsort)
echo "Testing 2 of 7 Inputs" $(printf "conc([X|R],L,[X|T]):-conc(R,L,T).\n\n" | ./qsort)
echo "Testing 3 of 7 Inputs" $(printf "split([],E,[],[]).\n\n" | ./qsort)
echo "Testing 4 of 7 Inputs" $(printf "split([X|R],E,[X|K],G):-X<E,split(R,E,K,G).\n\n" | ./qsort)
echo "Testing 5 of 7 Inputs" $(printf "split([X|R],E,K,[X|G]):-X>=E,split(R,E,K,G).\n\n" | ./qsort)
echo "Testing 6 of 7 Inputs" $(printf "qsort([],[]).\n\n" | ./qsort)
echo "Testing 7 of 7 Inputs" $(printf "qsort([E|R],S):-split(R,E,K,G),qsort(K,SK),qsort(G,SG),conc(SK,[E|SG],S).\n\n" | ./qsort)
