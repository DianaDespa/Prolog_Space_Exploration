% Despa Diana Alexandra 321CA

% In ProgramDataInitial retin pozitia initiala, faptul ca robotul nu livreaza
% nicio cutie la inceput, faptul ca nu s-a mutat anterior si numarul de cutii
% pe care trebuie sa le gaseasca.
% initMyData(+NBoxesToPick, -ProgramDataInitial).
initMyData(N, [(0, 0), 0, [], N]).

% Intoarce directia urmatoare in functie de directia curenta, si sensul de
% parcurgere la spatiului - spirala in sensul acelor de ceasornic.
% nextDir(+Dir, -NextDir).
nextDir(north, east).
nextDir(east, south).
nextDir(south, west).
nextDir(west, north).

% Determina urmatoarea directie de mutare in functie de directia anterioara si
% cat mai are de parcurs din regiunea curenta.
% O regiune este formata din o linie si o coloana consecutive in spatiu in care
% se misca robotul, avand aceeasi lungime - Length. Step retine numarul de
% mutari facute in cadrul unei linii sau coloane din regiune, SameLenStep retine
% a cata linie/ coloana a fost parcursa din setul de 2.
% Astfel de mutari succesive permit explorarea spatiului in spirala.
% nextMove(+[Dir, Step, Length, SameLenStep], -[NextDir, NewStep, NewL, NewSLS])
nextMove([Dir, L, L, 2], [NextDir, 1, NewL, 1]):-
	NewL is L + 1, nextDir(Dir, NextDir), !. % trece la o noua regiune
nextMove([Dir, L, L, SLS], [NextDir, 1, L, NewSLS]) :-
	NewSLS is SLS + 1, nextDir(Dir, NextDir), !. % trece la o noua linie/ coloana
nextMove([Dir, S, L, SLS], [Dir, NewS, L, SLS]) :-
	NewS is S + 1. % merge mai departe pe linie/ coloana

% Noile coordonate in functie de mutarea aleasa.
% nextCoord(+(I,J), +move, -(NewI,NewJ))
nextCoord((I, J), north, (NewI, J)) :- NewI is I + 1.
nextCoord((I, J), east, (I, NewJ)) :- NewJ is J + 1.
nextCoord((I, J), south, (NewI, J)) :- NewI is I - 1.
nextCoord((I, J), west, (I, NewJ)) :- NewJ is J - 1.

% Directia de mutare dintr-o structura de mutare.
getDir([Dir, _, _, _], Dir).

% Realizeaza deplasarea robotului in spatiu.
% perform(+ProgramData, +ContainsBox, -Action, -ProgramDataUpdated)

% Se afla in punctul de plecare si nu mai are de livrat cutii
perform([(0, 0), _, _, 0], _, done, _).

% Este intr-o camera unde se afla o cutie => pickBox, actualizez parametrul
% care indica livrarea in curs.
perform([Pos, 0, _, N], true, pickBox, [Pos, 1, [], N]).

% Se afla in origine si aduce o cutie => deliverBox, lasa cutia si devine liber.
% sa caute alta; nr de cutii cautate scade cu 1.
perform([(0, 0), 1, _, N], _, deliverBox, [(0, 0), 0, [], NewN]) :- NewN is N - 1.

% Nu are cutie, trebuie sa inceapa cautarea.
perform([Pos, 0, [], N], _, move(north), [NewPos, 0, [north, 1, 1, 1], N]) :-
	nextCoord(Pos, north, NewPos).

% Nu are cutie, continua sa caute.
perform([Pos, 0, Move, N], _, move(Dir), [NewPos, 0, NewMove, N]) :-
	nextMove(Move, NewMove),
	getDir(NewMove, Dir),
	nextCoord(Pos, Dir, NewPos).

% Are cutie, trebuie sa livreze si se intoarce in origine.
perform([(I, J), 1, BoxPos, N], _, moveWithBox(south), [(NewI, J), 1, BoxPos, N]) :-
	I > 0, NewI is I - 1,!.
perform([(I, J), 1, BoxPos, N], _, moveWithBox(north), [(NewI, J), 1, BoxPos, N]) :-
	I < 0, NewI is I + 1, !. 
perform([(0, J), 1, BoxPos, N], _, moveWithBox(west), [(0, NewJ), 1, BoxPos, N]) :-
	J > 0, NewJ is J - 1, !.
perform([(0, J), 1, BoxPos, N], _, moveWithBox(east), [(0, NewJ), 1, BoxPos, N]) :-
	J < 0, NewJ is J + 1, !.
	
% pentru bonus:
% perform(+ProgramData, +ContainsBox, +AvailableDirections,
%                                   -Action, -ProgramDataUpdated)
perform(_, _, _, done, _).