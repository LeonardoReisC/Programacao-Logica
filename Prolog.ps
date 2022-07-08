ap([],L,L).
ap([A|B],C,[A|D]) :- ap(B,C,D).

apaga(A,[A|B],B).
apaga(A,[B|C],[B|D]) :- apaga(A,C,D).

comp([],0).
comp([_|R],N1) :- comp(R,N), N1 is N + 1.

soma([],0).
soma([C|R],S1) :- soma(R,S), S1 is S + C.

seleciona(X,[X|Y],Y).
seleciona(X,[Y|Z],[Y|W]) :- seleciona(X,Z,W).

permuta(A,[B|D]) :- seleciona(B,A,C), permuta(C,D).
permuta([],[]).

%reversa extrai a cabeça(A), inverte a calda(B) e concatena(ap) a cauda invertida(Brev) com [A] 
reversa([],[]).
reversa([A|B],L) :- reversa(B,Brev), ap(Brev,[A],L).

pertence(A,[A|_]).
pertence(A,[_|B]) :- pertence(A,B).

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

% "length(L,3),maplist(between(0,1),L)": cria uma lista de comprimento 3 tais que seus elementos são números entre 0 e 1


%call: chama a função do parêmetro e passa Y e Z como parâmetros da função X
operacao(X,Y,Z) :- call(X,Y,Z).
