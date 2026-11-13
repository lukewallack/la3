#!/bin/gprolog --consult-file

:- include('data.pl').
:- include('uniq.pl').

% Helper: convert time slot to minutes (am = 0 to 719) using
% the formula `(H % 12)*60 + M` where H = hours, M = minutes.
tomins(time(H, M, am), Mins) :- 
	Hours is H mod 12,
	Mins is Hours * 60 + M.

% Helper: convert time slot to minutes (pm = 720 to 1439) using
% the formula `((H % 12) + 12)*60 + M` where H = hours, M = minutes.
tomins(time(H, M, pm), Mins) :- 
	Hours is H mod 12,
	Mins is (Hours + 12) * 60 + M.

% Define lte (less than or equal to) predicate.
% Compares the converted times in minutes of T1 and T2.
lte(T1, T2) :- 
	tomins(T1, Time1),
	tomins(T2, Time2),
	Time1 =< Time2.

% Define meet/1. 
meet(Slot) :- 
    .

% Define meet (base case). In this case, only one person remains, 
% so any of their free slots will work.
meet([Person], Slot) :-
    free(Person).

% Define meet (recursive case). In this case, ...
meet([Person,Person2|Tail], Slot) :-
    .

people([ann,bob,carla]).

main :- findall(Slot, meet(Slot), Slots),
        uniq(Slots, Uniq),
        write(Uniq), nl, halt.

:- initialization(main).
