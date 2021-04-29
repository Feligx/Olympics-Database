COPY athlete
from 'C:\Users\lunag\OneDrive\Documentos\MACC 2021-1\Bases_datos\Proyecto\person.csv' 
with 
NULL '0'
delimiter ','
csv header; 

select * from athlete;

COPY represents
from 'C:\Users\lunag\OneDrive\Documentos\MACC 2021-1\Bases_datos\Proyecto\person_region.csv' 
with 
delimiter ','
csv header; 

select * from represents;

COPY participates
from 'C:\Users\lunag\OneDrive\Documentos\MACC 2021-1\Bases_datos\Proyecto\games_competitor.csv' 
with 
delimiter ','
csv header; 

select * from participates;


COPY competes
from 'C:\Users\lunag\OneDrive\Documentos\MACC 2021-1\Bases_datos\Proyecto\competitor_event.csv' 
with 
delimiter ','
csv header; 

select * from competes;

select * from athlete; 
select * from category; 
select * from city;
select * from event;
select * from event_city;
select * from event_sport; --vacia
select * from medal;
select * from participates;
select * from region;
select * from represents;
select * from sport;
