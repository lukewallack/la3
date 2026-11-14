free(ann,slot(time(8,0,am),time(9,0,am))).
free(ann,slot(time(10,0,am),time(11,0,am))).
free(ann,slot(time(8,0,pm),time(9,0,pm))).

free(bob,slot(time(7,0,am),time(8,30,am))).
free(bob,slot(time(10,0,am),time(11,0,am))).
free(bob,slot(time(11,30,am),time(9,0,pm))).

free(carla,slot(time(8,0,am),time(9,0,am))).
free(carla,slot(time(10,0,am),time(10,15,am))).
free(carla,slot(time(11,0,am),time(8,30,pm))).

free(dave,slot(time(8,0,am),time(9,0,am))).
free(dave,slot(time(10,0,am),time(11,0,am))).

free(ed,slot(time(9,0,am),time(10,0,am))).

% Additional test facts
% Boundary (noon)
free(fred,slot(time(12,0,pm),time(2,0,pm))).
free(gabe,slot(time(11,0,am),time(1,0,pm))).

% Boundary (midnight)
free(hide,slot(time(12,0,am),time(2,0,am))).
free(isaac,slot(time(12,30,am),time(1,0,am))).

% Same time (0 minutes check)
free(jason,slot(time(12,0,am),time(12,0,am))).
free(kaneki,slot(time(11,0,pm),time(11,0,pm))).
free(loukandros,slot(time(1,0,am),time(11,0,pm))).