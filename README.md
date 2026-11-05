# LA3: Prolog
Author: lukew
Class: CS354 001
Semester: Fall 2026

## Overview
There are two main programs here: `meetone.pl` and `meet.pl`.

`meetone.pl` is a simpler program that uses facts stored in `data.pl`, which define a set of free times for a set of people. From these free times, we can then query certain time slots to determine who is able to meet at that time.

`meet.pl` is the main program which extends the abilities from `meetone.pl` to print a list of compatible meeting times for all people in the set (so we expect times where ALL people are free).

## Usage
...

## Deliverables
`meetone.pl`: given a time slot query, output the people who are free during the queried time slot.

`meet.pl`: output a list of compatible meeting times for **all** people in a set.

`data.pl`: modify to test solution.