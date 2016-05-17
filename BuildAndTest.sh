#/bin/bash

bison qsort.y -d
flex qsort.l
gcc -o qsort qsort.tab.c lex.yy.c -lfl 
rm lex.yy.c qsort.tab.c qsort.tab.h

echo -e "Testing Input 1 of 9 conc([],L,L).\n""$(printf "conc([],L,L).\n" | ./qsort)"
echo -e "Testing Input 2 of 9 conc([X|R],L,[X|T]):-conc(R,L,T).\n""$(printf "conc([X|R],L,[X|T]):-conc(R,L,T).\n" | ./qsort)"
echo -e "Testing Input 3 of 9 split([],E,[],[]).\n""$(printf "split([],E,[],[]).\n" | ./qsort)"
echo -e "Testing Input 4 of 9 split([X|R],E,[X|K],G):-X<E,split(R,E,K,G).\n""$(printf "split([X|R],E,[X|K],G):-X<E,split(R,E,K,G).\n" | ./qsort)"
echo -e "Testing Input 5 of 9 split([X|R],E,K,[X|G]):-X>=E,split(R,E,K,G).\n""$(printf "split([X|R],E,K,[X|G]):-X>=E,split(R,E,K,G).\n" | ./qsort)"
echo -e "Testing Input 6 of 9 qsort([],[]).\n""$(printf "qsort([],[]).\n" | ./qsort)"
echo -e "Testing Input 7 of 9 qsort([E|R],S):-split(R,E,K,G),qsort(K,SK),qsort(G,SG),conc(SK,[E|SG],S).\n""$(printf "qsort([E|R],S):-split(R,E,K,G),qsort(K,SK),qsort(G,SG),conc(SK,[E|SG],S).\n" | ./qsort)"

echo -e "Testing Input 8 of 9 p(X):-q(X),r(X),s(X).\n""$(printf "p(X):-q(X),r(X),s(X).\n" | ./qsort)"
echo -e "Testing Input 9 of 9 p(A,B,C,D):-q(A,B),r(A,C),s(B,D),l(C,D).\n""$(printf "p(A,B,C,D):-q(A,B),r(A,C),s(B,D),l(C,D).\n" | ./qsort)"
