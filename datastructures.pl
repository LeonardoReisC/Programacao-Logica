% Pilha
empilha(A,B,[A|B]) :- !.
desempilha(A,[A|B],B) :- !.

empLista([A|B],X,Z) :- empilha(A,X,Y), !, empLista(B,Y,Z).
empLista([],A,A) :- !.

%---------------------------------------------------------------------------
% Fila
insere(A,B,F) :- append(B,[A],F), !.
retira(A,[A|B],B) :- !. %igual ao desempilha

insLista([A|B],X,Z) :- insere(A,X,Y), !, insLista(B,Y,Z).
insLista([],A,A) :- !.

%---------------------------------------------------------------------------
% Árvore Binária
% Uma representação de árvore em Prolog
% no(raiz, esq, dir)
no(a,b,c).
no(b,d,[]).
no(d,[],[]).
no(c,e,f).
no(e,[],g).
no(f,[],[]).
no(g,[],[]).

preordem([]) :- !.
preordem(X) :-
	write(X), write(' '), no(X,E,D), preordem(E), preordem(D).

emordem([]) :- !.
emordem(no(X,E,D)) :- 
    emordem(E), write(X), write(' '), emordem(D).

% Outra representação para árvore
insereArvore(X,[],no(X,[],[])) :- !. % insere X em uma árvore vazia
insereArvore(X,no(X,E,D),no(X,E,D)) :- !. % X já raíz da (sub)árvore
insereArvore(X,no(I,E,D),no(I,E1,D)) :- X < I, !, insereArvore(X,E,E1).
insereArvore(X,no(I,E,D),no(I,E,D1)) :- X > I, !, insereArvore(X,D,D1).

% Lê uma lista e altera a (sub)árvore de raiz X e resultará em Z
listaArvore([A|B],X-Z) :- !, insereArvore(A,X,Y), listaArvore(B,Y-Z).
listaArvore([],A-A) :- !.
% ex.: listaArvore([4,1,5,9,2],[]-A).
% outro ex.: listaArvore([4,1,5,9,2],[]-A), listaArvore([7,8],A-B).

%---------------------------------------------------------------------------
% Escreve na saída uma representação da árvore
% ex.: listaArvore([4,1,5,9,2],[]-A), listaArvore([7,8],A-B), mostra(B, 0).
tabula(0) :- !.
tabula(N) :- N>0, write("....."), N1 is N-1, tabula(N1).

mostra([], _).
mostra(no(I,E,D), N) :- 
    N1 is N+1, 
    mostra(D, N1), 
    tabula(N), write(I), nl, 
    mostra(E, N1).

%---------------------------------------------------------------------------
