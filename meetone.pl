#!/bin/gprolog --consult-file

:- include('data.pl').

% Define lte (less than or equal to) predicate.
lte(T1, T2) :- T1 =< T2.

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
