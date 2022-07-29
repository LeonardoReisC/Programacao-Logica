%Funções genéricas
apaga(A,[A|B],B).
apaga(A,[B|C],[B|D]) :- apaga(A,C,D).

permuta(A,[B|C]) :- apaga(B,A,D), permuta(D,C).
permuta([],[]).

ap([],L,L).
ap([A|B],C,[A|D]) :- ap(B,C,D).

%----------------------------------------------------------------------------------------------------
% Pilha
empilha(A,B,[A|B]) :- !.
desempilha(A,[A|B],B) :- !.

empLista([A|B],X,Z) :- empilha(A,X,Y), !, empLista(B,Y,Z).
empLista([],A,A) :- !.

%----------------------------------------------------------------------------------------------------
% Fila
insere(A,B,F) :- append(B,[A],F), !.
retira(A,[A|B],B) :- !. %igual ao desempilha

insLista([A|B],X,Z) :- insere(A,X,Y), !, insLista(B,Y,Z).
insLista([],A,A) :- !.

%----------------------------------------------------------------------------------------------------
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

%----------------------------------------------------------------------------------------------------
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

%----------------------------------------------------------------------------------------------------
%Ordenação
%Verifica se está a lista L está em ordem
ordem([_]).
ordem([A,B|C]) :- A =< B, ordem([B|C]).

insereOrd(X,[Y|L], [X,Y|L]) :- X =< Y, !.
insereOrd(X,[Y|L], [Y|Io]) :- X > Y, !, insereOrd(X,L,Io).
insereOrd(X,[],[X]).

%Insertion Sort: Ordena a lista inserindo os elementos em uma lista solução
sortInsertion([C|Ls],So) :- sortInsertion(Ls,Si), insereOrd(C,Si,So).
sortInsertion([],[]).

/* Selection Sort: L resulta em [M|S] se M for o menor valor da lista. Dessa forma, o algoritmo
 * encontra, recursivamente, uma lista com o menor elemento de L no início de S, realizando o 
 * backtracking */

sortSelection(L,[M|S]) :- removeMin(M,L,Lo), sortSelection(Lo,S), !.
sortSelection([],[]).

min([X],X).
min([A|B],M) :- min(B,M1),(A < M1 -> M = A ; M = M1), !.

removeMin(M,L,S) :- min(L,M), apaga(M,L,S).

%?
ordenacaoTroca(L,S) :-
    ap(X,[A,B|C],L), B < A, !,
    ap(X,[B,A|C],Li),
    ordenacaoTroca(Li,S).
ordenacaoTroca(L,L).

/* QuickSort: funciona como uma árvore binária. Valores menores que o Pivo vão para a lista da 
 * 			  esquerda e maiores/iguais para a da direita(Partição). Em seguida, ordena-se, 
 * 			  recursivamente, as listas resultados e depois concatena as ordenações resultantes 
 * 			  com o pivo. */
quickSort([A|B],S) :-
    particao(B,A,Me,Ma),
    quickSort(Me,MeOrd),
    quickSort(Ma,MaOrd),
    ap(MeOrd,[A|MaOrd],S).
quickSort([],[]).

particao([X|L],Pivo,[X|Menores],Maiores) :- 
    X<Pivo, !, particao(L,Pivo,Menores,Maiores).
particao([X|L],Pivo,Menores,[X|Maiores]) :-
    X>=Pivo, !, particao(L,Pivo,Menores,Maiores).
particao([],_,[],[]).
