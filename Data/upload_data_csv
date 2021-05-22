--Carga de archivos csv, cuando los documentos se encuentran en C
--Proceso transparente, sin problemas ni modificaciones.

COPY athlete(id,full_name,gender,height,weight)
FROM 'C:\person.csv'
DELIMITER ','
CSV HEADER;

COPY represents(id_athlete,id_region)
FROM 'C:\person_region.csv'
DELIMITER ','
CSV HEADER;

COPY participates(id, id_event, id_athlete, age)
FROM 'C:\games_competitor.csv'
DELIMITER ','
CSV HEADER;

select * from competes;
COPY competes(id_category, id_participates, id_medal)
FROM 'C:\competitor_event.csv'
DELIMITER ','
CSV HEADER;
