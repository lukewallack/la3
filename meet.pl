#!/bin/gprolog --consult-file

:- include('data.pl').
:- include('uniq.pl').

% Helper: convert time slot to minutes (am = 0 to 719) using
% the formula `(H % 12)*60 + M` where H = hours, M = minutes.
% Outputs `Mins`: time in minutes
tomins(time(H, M, am), Mins) :- 
	Hours is H mod 12,
	Mins is Hours * 60 + M.

% Helper: convert time slot to minutes (pm = 720 to 1439) using
% the formula `((H % 12) + 12)*60 + M` where H = hours, M = minutes.
% Outputs `Mins`: time in minutes
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
% Outputs `Slot`: meeting time that works for all people.
meet(Slot) :- 
    people(People),		% Bind `people` list to variable `People`.
	meet(People, Slot). % Send `People` to meet/2 which will recursively handle the list of people.

% Define meet/2 (base case). In this case, only one person remains, 
% so any of their free slots will work.
meet([Person], Slot) :-
    free(Person, Slot). % Bind `Slot` to a free slot.

% Define meet/2 (recursive case). In this case, we handle a list of
% more than one person and go through each person recursively to determine 
% when each person can meet with all the others.
% Person, Person2, Tail are variables representing the first person in the 
% list, the second person, and then the rest of the people in the list.
meet([Person,Person2|Tail], slot(Start, End)) :-
    free(Person, slot(Start1, End1)),							% One of `Person`'s free slots.
	meet([Person2|Tail], slot(Start2, End2)), 					% Recurse on the rest of the list.
	(lte(Start1, Start2) -> Start = Start2 ; Start = Start1), 	% Start is the latest start time between Start1 & Start2
	(lte(End1, End2) -> End = End1 ; End = End2),				% End is the earliest end time between End1 & End2
	lte(Start, End),											% Start must come before End to overlap.
	Start \== End.												% A meeting time of 0 is not valid.

people([ann,bob,carla]).

main :- findall(Slot, meet(Slot), Slots),
        uniq(Slots, Uniq),
        write(Uniq), nl, halt.

:- initialization(main).
