%concatena listas na ordem dos argumentos
ap([],L,L).
ap([A|B],C,[A|D]) :- ap(B,C,D).

apaga(A,[A|B],B).
apaga(A,[B|C],[B|D]) :- apaga(A,C,D).

comp([],0).
comp([_|R],N1) :- comp(R,N), N1 is N + 1.

soma([],0).
soma([C|R],S1) :- soma(R,S), S1 is S + C.
%---------------------------------------------------------------------------------------------------
seleciona(X,[X|Y],Y).
seleciona(X,[Y|Z],[Y|W]) :- seleciona(X,Z,W).

permuta1(A,[B|D]) :- seleciona(B,A,C), permuta1(C,D).
permuta1([],[]).

%reversa extrai a cabeça(A), inverte a calda(B) e concatena(ap) a cauda invertida(Brev) com [A] 
reversa([],[]).
reversa([A|B],L) :- reversa(B,Brev), ap(Brev,[A],L).

pertence(A,[A|_]).
pertence(A,[_|B]) :- pertence(A,B).
%---------------------------------------------------------------------------------------------------
%corte(!): impede o backtracking nas condições anteriores a ele na mesma regra e nas regras abaixo dele
insere(A,L,L) :- pertence(A,L), !.
insere(X,Y,L) :- ap(Y,[X],L).

%Findall: gera uma lista que satisfaça a uma consulta
%forall(CONTROLE, DO): imita o comando "for"
%between(INIC, FIM, !): ?
%maplist: ?

%EXEMPLOS: "findall(X,between(1,6,X),L)."|"findall(X,permuta([1,2,3],X),L)."
% "forall(between(1,10,X),(write(X),nl))."
vezes3([],[]).
vezes3([A|B],[X|Y]) :- X is A*3, vezes3(B,Y).

mult(X,Y,Z) :- Z is X*Y.
%EXEMPLOS: "maplist(vezes3,[[1,2,3],[2,3,4]],L)."|"maplist(mult(2),[1,2,3,4],L)."
% "maplist(mult,[1,2,3,4],[2,3,4,5],L)." | "maplist(comp,[[3,4,5],[1,2,6,5]],L)."

% "length(L,3),maplist(between(0,1),L)": cria uma lista de comprimento 3 tais que seus elementos 
% 										 são números entre 0 e 1


%call: chama a função do parêmetro e passa Y e Z como parâmetros da função X
operacao(X,Y,Z) :- call(X,Y,Z).
%---------------------------------------------------------------------------------------------------
%UTILIZAÇÃO DE OUTROS PREDICADOS
membro(X,L) :- ap(_,[X|_],L).
ultimo(U,L) :- ap(_,[U],L).
prefixo(P,L) :- ap(P,_,L).
sufixo(S,L) :- ap(_,S,L).
sublista(S,L) :- prefixo(P,L), sufixo(S,P).

permuta2(A,[B|C]) :- apaga(B,A,D), permuta2(D,C).
permuta2([],[]).

ordem([_]) :- !.
ordem([A,B|C]) :- A=<B, ordem([B|C]).

%PROBLEMA DAS 4 RAINHAS: posiciona as rainhas no tabuleiro de modo que nenhuma esteja ao alcance
%						 direto de outra
%S: conjunto de colunas onde as rainhas serão posicionas baseado na ordem crecente das linhas
solucao1(S) :-
resolve1(S,[1,2,3,4],[1,2,3,4],[3,2,1,0,-1,-2,-3],[2,3,4,5,6,7,8]).
resolve1([], [], _, _, _).
resolve1([C|LC],[L|LL],CO,DS,DI):-
	apaga(C,CO,CO1), NS is L - C,
	apaga(NS,DS,DS1),NI is L + C,
	apaga(NI,DI,DI1),
	resolve(LC,LL,CO1,DS1,DI1).

%PROBLEMA DAS 8 RAINHAS
solucao2(S) :-
resolve1(S,[1,2,3,4,5,6,7,8],[1,2,3,4,5,6,7,8],
        [7,6,5,4,3,2,1,0,-1,-2,-3,-4,-5,-6,-7],[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]).

%PROBLEMA DAS N RAINHAS(REFATORAÇÃO)
%":- use_rendering(chess).": incluir na 1ª linha do arquivo para disponibilizar na saída o tabuleiro
solucao(N,S) :-
    findall(X,between(1,N,X),L),
    N2 is N-1, N1 is -1*(N-1),
    findall(X,between(N1,N2,X),DS),
    N3 is 2*N, 
    findall(X,between(2,N3,X),DI),
	resolve(S,L,L,DS,DI).
resolve([], [], _, _, _).
resolve([C|LC],[L|LL],CO,DS,DI):-
	apaga(C,CO,CO1), NS is L - C,
	apaga(NS,DS,DS1),NI is L + C,
	apaga(NI,DI,DI1),
	resolve(LC,LL,CO1,DS1,DI1).

%PROGRAMAÇÃO PROCEDURAL
prog :- ledado(X), calcula(X,R), escreve(R).

ledado(X) :- write('Digite um valor: '), read(X).

calcula(X,R) :- R is X*X.
escreve(R) :- write('O quadrado eh: '), write(R), nl.
%---------------------------------------------------------------------------------------------------
