#!/bin/gprolog --consult-file

:- include('data.pl').

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

% Define meetone. A meeting is valid if there exists 
% a person defined in `data.pl` whose free time slots
% are available from QueryTimeStart AND til QueryTimeEnd.
meetone(Person, slot(QueryTimeStart, QueryTimeEnd)) :-
	free(Person, slot(TimeStart, TimeEnd)), % Bind Person to a valid fact in data.pl
	lte(TimeStart, QueryTimeStart), % Check 1: can we meet starting at QueryTimeStart?
	lte(QueryTimeEnd, TimeEnd). % Check 2: can we also meet til QueryTimeEnd?

main :- findall(Person,
		meetone(Person,slot(time(8,30,am),time(8,45,am))),
		People),
	write(People), nl, halt.

:- initialization(main).
