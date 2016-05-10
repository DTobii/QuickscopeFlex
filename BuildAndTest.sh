#/bin/bash

bison qsort.y -d
flex qsort.l
gcc -o qsort qsort.tab.c lex.yy.c -lfl 
rm lex.yy.c qsort.tab.c qsort.tab.h

echo "Testing Input 1 of 7" $(printf "conc([],L,L).\n\n" | ./qsort)
echo "Testing Input 2 of 7" $(printf "conc([X|R],L,[X|T]):-conc(R,L,T).\n\n" | ./qsort)
echo "Testing Input 3 of 7" $(printf "split([],E,[],[]).\n\n" | ./qsort)
echo "Testing Input 4 of 7" $(printf "split([X|R],E,[X|K],G):-X<E,split(R,E,K,G).\n\n\n\n" | ./qsort)
echo "Testing Input 5 of 7" $(printf "split([X|R],E,K,[X|G]):-X>=E,split(R,E,K,G).\n\n\n\n" | ./qsort)
echo "Testing Input 6 of 7" $(printf "qsort([],[]).\n\n" | ./qsort)
echo "Testing Input 7 of 7" $(printf "qsort([E|R],S):-split(R,E,K,G),qsort(K,SK),qsort(G,SG),conc(SK,[E|SG],S).\n\n" | ./qsort)
