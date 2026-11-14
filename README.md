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

`data.pl`: modified to test solution.

## Journal
`meet.pl`:
Creating the meet recursive predicate is very confusing to me so I am going to journal a lot of my thoughts here.

In order to find the times for which each person in a list can meet, we have to define a meet predicate that handles two cases:

1. We have a list of people containing only a single person.
2. We have a list of people containing more than one person.

In case 1, all we have to do is return a free slot from that single person.

In case 2, things get more complicated. Now, we are dealing with a list that contains more than one person.

To begin, I broke this list up into `[Person,Person2|Tail]`. This allows me to compare the first person `Person`'s free slots to the rest of the list's free slots by recursively calling meet on the list `Person2|Tail`.

After recursively calling meet on the rest of the list, we now have variables `Start1`, `End1`, `Start2`, `End2` which contain time slots where each person is available, from start to end. We compare these timeslots using the `lte` predicate that I made during `meetone.pl` to unify variables `Start` and `End` to a final start and end time. The final start and end time should be the latest time from all of the people's compatible start times, and the earliest end from all of their end times.

Finally, we validate the `Start` and `End` variables by checking that `Start` comes before `End`, and that they are not the same time (so no meeting times of 0 minutes).

After completing the above, I was able to get the expected output without changing anything in `data.pl` or the `people` list:
```
[slot(time(8,0,am),time(8,30,am)),slot(time(10,0,am),time(10,15,am)),slot(time(8,0,pm),time(8,30,pm))]

= 8:00AM-8:30AM, 10:00AM-10:15AM, 8:00PM-8:30PM.
```

When I alter the people list:

`people([ann,bob,carla,ed]).`:
```
[]

= no valid meeting times
```

`people([ann,bob]).`:
```
[slot(time(8,0,am),time(8,30,am)),slot(time(10,0,am),time(11,0,am)),slot(time(8,0,pm),time(9,0,pm))]

= 8:00AM-8:30AM, 10:00AM-11:00AM, 8:00PM-9:00PM
```

`people([ann]).`:
```
[slot(time(8,0,am),time(9,0,am)),slot(time(10,0,am),time(11,0,am)),slot(time(8,0,pm),time(9,0,pm))]

= 8:00AM-9:00AM, 10:00AM-11:00AM, 8:00PM-9:00PM
```
So, altering the people list still gives the expected output.

To confirm that everything works completely as expected, I am now working on adding some additional test facts to `data.pl`. I need to test the boundary cases at noon and midnight, and then when the times are the same as well to check the 0 minute long meeting scenario.

Boundary case (noon):
`people([fred,gabe]).`
```
[slot(time(12,0,pm),time(1,0,pm))]

= 12:00PM-1:00PM
```

Boundary case (midnight):
`%people([hide,isaac]).`
```
[slot(time(12,30,am),time(1,0,am))]

= 12:30AM-1:00AM
```

0 minutes case:
`people([jason,kaneki,loukandros]).`
```
[]

= no valid meeting times
```

Now everything works as intended!