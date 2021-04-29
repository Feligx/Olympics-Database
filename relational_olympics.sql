-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.2
-- PostgreSQL version: 12.0
-- Project Site: pgmodeler.io
-- Model Author: ---


-- Database creation must be done outside a multicommand file.
-- These commands were put in this file only as a convenience.
-- -- object: new_database | type: DATABASE --
-- -- DROP DATABASE IF EXISTS new_database;
-- CREATE DATABASE new_database;
-- -- ddl-end --
--

-- object: public.region | type: TABLE --
-- DROP TABLE IF EXISTS public.region CASCADE;
CREATE TABLE public.region (
	id integer NOT NULL,
	noc char(5) NOT NULL,
	region_name varchar(40) NOT NULL,
	CONSTRAINT "Region_pk" PRIMARY KEY (id)

);
-- ddl-end --
-- ALTER TABLE public.region OWNER TO postgres;
-- ddl-end --

-- object: public.athlete | type: TABLE --
-- DROP TABLE IF EXISTS public.athlete CASCADE;
CREATE TABLE public.athlete (
	id integer NOT NULL,
	full_name varchar(200) NOT NULL,
	gender varchar(1),
	height integer DEFAULT NULL,
	weight integer DEFAULT NULL,
	CONSTRAINT "Athlete_pk" PRIMARY KEY (id)

);
-- ddl-end --
-- ALTER TABLE public.athlete OWNER TO postgres;
-- ddl-end --

-- object: public.city | type: TABLE --
-- DROP TABLE IF EXISTS public.city CASCADE;
CREATE TABLE public.city (
	id integer NOT NULL,
	city_name varchar(100) NOT NULL,
	CONSTRAINT "City_pk" PRIMARY KEY (id)

);
-- ddl-end --
-- ALTER TABLE public.city OWNER TO postgres;
-- ddl-end --

-- object: public.event | type: TABLE --
-- DROP TABLE IF EXISTS public.event CASCADE;
CREATE TABLE public.event (
	id integer NOT NULL,
	year integer NOT NULL,
	event_name varchar(100) NOT NULL,
	season char(7) NOT NULL,
	CONSTRAINT "Event_pk" PRIMARY KEY (id)

);
-- ddl-end --
-- ALTER TABLE public.event OWNER TO postgres;
-- ddl-end --

-- object: public.sport | type: TABLE --
-- DROP TABLE IF EXISTS public.sport CASCADE;
CREATE TABLE public.sport (
	id integer NOT NULL,
	sport_name varchar(200) NOT NULL,
	CONSTRAINT "Sport_pk" PRIMARY KEY (id)

);
-- ddl-end --
-- ALTER TABLE public.sport OWNER TO postgres;
-- ddl-end --

-- object: public.category | type: TABLE --
-- DROP TABLE IF EXISTS public.category CASCADE;
CREATE TABLE public.category (
	id integer NOT NULL,
	id_sport integer,
	category_name varchar(300) NOT NULL,
	CONSTRAINT "Category_pk" PRIMARY KEY (id)

);
-- ddl-end --
-- ALTER TABLE public.category OWNER TO postgres;
-- ddl-end --

-- object: public.medal | type: TABLE --
-- DROP TABLE IF EXISTS public.medal CASCADE;
CREATE TABLE public.medal (
	id integer NOT NULL,
	medal_name varchar(10) NOT NULL,
	CONSTRAINT "Medal_pk" PRIMARY KEY (id)

);
-- ddl-end --
-- ALTER TABLE public.medal OWNER TO postgres;
-- ddl-end --

-- object: sport_fk | type: CONSTRAINT --
-- ALTER TABLE public.category DROP CONSTRAINT IF EXISTS sport_fk CASCADE;
ALTER TABLE public.category ADD CONSTRAINT sport_fk FOREIGN KEY (id_sport)
REFERENCES public.sport (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.event_city | type: TABLE --
-- DROP TABLE IF EXISTS public.event_city CASCADE;
CREATE TABLE public.event_city (
	id_event integer NOT NULL,
	id_city integer NOT NULL,
	CONSTRAINT event_city_pk PRIMARY KEY (id_city,id_event)

);
-- ddl-end --
-- ALTER TABLE public.event_city OWNER TO postgres;
-- ddl-end --

-- object: city_fk | type: CONSTRAINT --
-- ALTER TABLE public.event_city DROP CONSTRAINT IF EXISTS city_fk CASCADE;
ALTER TABLE public.event_city ADD CONSTRAINT city_fk FOREIGN KEY (id_city)
REFERENCES public.city (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: event_fk | type: CONSTRAINT --
-- ALTER TABLE public.event_city DROP CONSTRAINT IF EXISTS event_fk CASCADE;
ALTER TABLE public.event_city ADD CONSTRAINT event_fk FOREIGN KEY (id_event)
REFERENCES public.event (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.represents | type: TABLE --
-- DROP TABLE IF EXISTS public.represents CASCADE;
CREATE TABLE public.represents (
	id_athlete integer NOT NULL,
	id_region integer NOT NULL,
	CONSTRAINT represents_pk PRIMARY KEY (id_region,id_athlete)

);
-- ddl-end --
-- ALTER TABLE public.represents OWNER TO postgres;
-- ddl-end --

-- object: region_fk | type: CONSTRAINT --
-- ALTER TABLE public.represents DROP CONSTRAINT IF EXISTS region_fk CASCADE;
ALTER TABLE public.represents ADD CONSTRAINT region_fk FOREIGN KEY (id_region)
REFERENCES public.region (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: athlete_fk | type: CONSTRAINT --
-- ALTER TABLE public.represents DROP CONSTRAINT IF EXISTS athlete_fk CASCADE;
ALTER TABLE public.represents ADD CONSTRAINT athlete_fk FOREIGN KEY (id_athlete)
REFERENCES public.athlete (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.participates | type: TABLE --
-- DROP TABLE IF EXISTS public.participates CASCADE;
CREATE TABLE public.participates (
	id integer NOT NULL,
	id_event integer,
	id_athlete integer,
	age integer,
	CONSTRAINT "Participates_pk" PRIMARY KEY (id)

);
-- ddl-end --
-- ALTER TABLE public.participates OWNER TO postgres;
-- ddl-end --

-- object: athlete_fk | type: CONSTRAINT --
-- ALTER TABLE public.participates DROP CONSTRAINT IF EXISTS athlete_fk CASCADE;
ALTER TABLE public.participates ADD CONSTRAINT athlete_fk FOREIGN KEY (id_athlete)
REFERENCES public.athlete (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: event_fk | type: CONSTRAINT --
-- ALTER TABLE public.participates DROP CONSTRAINT IF EXISTS event_fk CASCADE;
ALTER TABLE public.participates ADD CONSTRAINT event_fk FOREIGN KEY (id_event)
REFERENCES public.event (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.competes | type: TABLE --
-- DROP TABLE IF EXISTS public.competes CASCADE;
CREATE TABLE public.competes (
	id_category integer NOT NULL,
	id_participates integer NOT NULL,
	id_medal integer NOT NULL
	--CONSTRAINT competes_pk PRIMARY KEY (id_participates,id_medal,id_category)

);
-- ddl-end --
-- ALTER TABLE public.competes OWNER TO postgres;
-- ddl-end --

-- object: participates_fk | type: CONSTRAINT --
-- ALTER TABLE public.competes DROP CONSTRAINT IF EXISTS participates_fk CASCADE;
ALTER TABLE public.competes ADD CONSTRAINT participates_fk FOREIGN KEY (id_participates)
REFERENCES public.participates (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: category_fk | type: CONSTRAINT --
-- ALTER TABLE public.competes DROP CONSTRAINT IF EXISTS category_fk CASCADE;
ALTER TABLE public.competes ADD CONSTRAINT category_fk FOREIGN KEY (id_category)
REFERENCES public.category (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: medal_fk | type: CONSTRAINT --
-- ALTER TABLE public.competes DROP CONSTRAINT IF EXISTS medal_fk CASCADE;
ALTER TABLE public.competes ADD CONSTRAINT medal_fk FOREIGN KEY (id_medal)
REFERENCES public.medal (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.event_sport | type: TABLE --
-- DROP TABLE IF EXISTS public.event_sport CASCADE;
CREATE TABLE public.event_sport (
	id_event integer NOT NULL,
	id_sport integer NOT NULL,
	CONSTRAINT event_sport_pk PRIMARY KEY (id_event,id_sport)

);
-- ddl-end --
-- ALTER TABLE public.event_sport OWNER TO postgres;
-- ddl-end --

-- object: event_fk | type: CONSTRAINT --
-- ALTER TABLE public.event_sport DROP CONSTRAINT IF EXISTS event_fk CASCADE;
ALTER TABLE public.event_sport ADD CONSTRAINT event_fk FOREIGN KEY (id_event)
REFERENCES public.event (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: sport_fk | type: CONSTRAINT --
-- ALTER TABLE public.event_sport DROP CONSTRAINT IF EXISTS sport_fk CASCADE;
ALTER TABLE public.event_sport ADD CONSTRAINT sport_fk FOREIGN KEY (id_sport)
REFERENCES public.sport (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --



INSERT INTO medal VALUES (1,'Gold'),(2,'Silver'),(3,'Bronze'),(4,'NA');

INSERT INTO city VALUES (1,'Barcelona'),(2,'London'),(3,'Antwerpen'),(4,'Paris'),(5,'Calgary'),(6,'Albertville'),(7,'Lillehammer'),(8,'Los Angeles'),(9,'Salt Lake City'),(10,'Helsinki'),(11,'Lake Placid'),(12,'Sydney'),(13,'Atlanta'),(14,'Stockholm'),(15,'Sochi'),(16,'Nagano'),(17,'Torino'),(18,'Beijing'),(19,'Rio de Janeiro'),(20,'Athina'),(21,'Squaw Valley'),(22,'Innsbruck'),(23,'Sarajevo'),(24,'Mexico City'),(25,'Munich'),(26,'Seoul'),(27,'Berlin'),(28,'Oslo'),(29,'Cortina d''Ampezzo'),(30,'Melbourne'),(31,'Roma'),(32,'Amsterdam'),(33,'Montreal'),(34,'Moskva'),(35,'Tokyo'),(36,'Vancouver'),(37,'Grenoble'),(38,'Sapporo'),(39,'Chamonix'),(40,'St. Louis'),(41,'Sankt Moritz'),(42,'Garmisch-Partenkirchen');

INSERT INTO sport VALUES (1,'Aeronautics'),(2,'Alpine Skiing'),(3,'Alpinism'),(4,'Archery'),(5,'Art Competitions'),(6,'Athletics'),(7,'Badminton'),(8,'Baseball'),(9,'Basketball'),(10,'Basque Pelota'),(11,'Beach Volleyball'),(12,'Biathlon'),(13,'Bobsleigh'),(14,'Boxing'),(15,'Canoeing'),(16,'Cricket'),(17,'Croquet'),(18,'Cross Country Skiing'),(19,'Curling'),(20,'Cycling'),(21,'Diving'),(22,'Equestrianism'),(23,'Fencing'),(24,'Figure Skating'),(25,'Football'),(26,'Freestyle Skiing'),(27,'Golf'),(28,'Gymnastics'),(29,'Handball'),(30,'Hockey'),(31,'Ice Hockey'),(32,'Jeu De Paume'),(33,'Judo'),(34,'Lacrosse'),(35,'Luge'),(36,'Military Ski Patrol'),(37,'Modern Pentathlon'),(38,'Motorboating'),(39,'Nordic Combined'),(40,'Polo'),(41,'Racquets'),(42,'Rhythmic Gymnastics'),(43,'Roque'),(44,'Rowing'),(45,'Rugby'),(46,'Rugby Sevens'),(47,'Sailing'),(48,'Shooting'),(49,'Short Track Speed Skating'),(50,'Skeleton'),(51,'Ski Jumping'),(52,'Snowboarding'),(53,'Softball'),(54,'Speed Skating'),(55,'Swimming'),(56,'Synchronized Swimming'),(57,'Table Tennis'),(58,'Taekwondo'),(59,'Tennis'),(60,'Trampolining'),(61,'Triathlon'),(62,'Tug-Of-War'),(63,'Volleyball'),(64,'Water Polo'),(65,'Weightlifting'),(66,'Wrestling');

INSERT INTO category VALUES (1,9,'Basketball Men''s Basketball'),(2,33,'Judo Men''s Extra-Lightweight'),(3,25,'Football Men''s Football'),(4,62,'Tug-Of-War Men''s Tug-Of-War'),(5,54,'Speed Skating Women''s 500 metres'),(6,54,'Speed Skating Women''s 1,000 metres'),(7,18,'Cross Country Skiing Men''s 10 kilometres'),(8,18,'Cross Country Skiing Men''s 50 kilometres'),(9,18,'Cross Country Skiing Men''s 10/15 kilometres Pursuit'),(10,18,'Cross Country Skiing Men''s 4 x 10 kilometres Relay'),(11,18,'Cross Country Skiing Men''s 30 kilometres'),(12,6,'Athletics Women''s 100 metres'),(13,6,'Athletics Women''s 4 x 100 metres Relay'),(14,31,'Ice Hockey Men''s Ice Hockey'),(15,55,'Swimming Men''s 400 metres Freestyle'),(16,7,'Badminton Men''s Singles'),(17,47,'Sailing Women''s Windsurfer'),(18,12,'Biathlon Women''s 7.5 kilometres Sprint'),(19,55,'Swimming Men''s 200 metres Breaststroke'),(20,55,'Swimming Men''s 400 metres Breaststroke'),(21,28,'Gymnastics Men''s Individual All-Around'),(22,28,'Gymnastics Men''s Team All-Around'),(23,28,'Gymnastics Men''s Floor Exercise'),(24,28,'Gymnastics Men''s Horse Vault'),(25,28,'Gymnastics Men''s Parallel Bars'),(26,28,'Gymnastics Men''s Horizontal Bar'),(27,28,'Gymnastics Men''s Rings'),(28,28,'Gymnastics Men''s Pommelled Horse'),(29,6,'Athletics Men''s Shot Put'),(30,5,'Art Competitions Mixed Sculpturing, Unknown Event'),(31,2,'Alpine Skiing Men''s Downhill'),(32,2,'Alpine Skiing Men''s Super G'),(33,2,'Alpine Skiing Men''s Giant Slalom'),(34,2,'Alpine Skiing Men''s Slalom'),(35,2,'Alpine Skiing Men''s Combined'),(36,29,'Handball Women''s Handball'),(37,65,'Weightlifting Women''s Super-Heavyweight'),(38,66,'Wrestling Men''s Light-Heavyweight, Greco-Roman'),(39,54,'Speed Skating Men''s 500 metres'),(40,54,'Speed Skating Men''s 1,500 metres'),(41,28,'Gymnastics Men''s Team All-Around, Free System'),(42,35,'Luge Women''s Singles'),(43,64,'Water Polo Men''s Water Polo'),(44,47,'Sailing Mixed Three Person Keelboat'),(45,30,'Hockey Women''s Hockey'),(46,44,'Rowing Men''s Lightweight Double Sculls'),(47,6,'Athletics Men''s Pole Vault'),(48,6,'Athletics Men''s High Jump'),(49,47,'Sailing Men''s Two Person Dinghy'),(50,6,'Athletics Men''s 1,500 metres'),(51,13,'Bobsleigh Men''s Four'),(52,55,'Swimming Men''s 100 metres Butterfly'),(53,55,'Swimming Men''s 200 metres Butterfly'),(54,55,'Swimming Men''s 4 x 100 metres Medley Relay'),(55,25,'Football Women''s Football'),(56,23,'Fencing Men''s Foil, Individual'),(57,23,'Fencing Men''s epee, Individual'),(58,23,'Fencing Men''s epee, Team'),(59,54,'Speed Skating Men''s 5,000 metres'),(60,54,'Speed Skating Men''s 10,000 metres'),(61,47,'Sailing Mixed 8 metres'),(62,22,'Equestrianism Mixed Jumping, Individual'),(63,18,'Cross Country Skiing Men''s 15 kilometres'),(64,48,'Shooting Men''s Small-Bore Rifle, Prone, 50 metres'),(65,48,'Shooting Men''s Rapid-Fire Pistol, 25 metres'),(66,48,'Shooting Men''s Trap'),(67,6,'Athletics Men''s 4 x 100 metres Relay'),(68,6,'Athletics Men''s Long Jump'),(69,14,'Boxing Men''s Light-Welterweight'),(70,6,'Athletics Women''s Javelin Throw'),(71,66,'Wrestling Men''s Heavyweight, Freestyle'),(72,58,'Taekwondo Men''s Flyweight'),(73,6,'Athletics Men''s 5,000 metres'),(74,20,'Cycling Men''s Road Race, Individual'),(75,20,'Cycling Men''s Road Race, Team'),(76,65,'Weightlifting Men''s Lightweight'),(77,65,'Weightlifting Men''s Middleweight'),(78,44,'Rowing Men''s Coxless Pairs'),(79,33,'Judo Men''s Half-Middleweight'),(80,58,'Taekwondo Women''s Flyweight'),(81,9,'Basketball Women''s Basketball'),(82,21,'Diving Men''s Platform'),(83,15,'Canoeing Men''s Canadian Doubles, 500 metres'),(84,15,'Canoeing Men''s Canadian Doubles, 1,000 metres'),(85,15,'Canoeing Men''s Kayak Fours, 1,000 metres'),(86,29,'Handball Men''s Handball'),(87,44,'Rowing Women''s Coxless Pairs'),(88,14,'Boxing Men''s Middleweight'),(89,33,'Judo Men''s Lightweight'),(90,14,'Boxing Men''s Featherweight'),(91,59,'Tennis Men''s Doubles'),(92,48,'Shooting Mixed Skeet'),(93,66,'Wrestling Men''s Featherweight, Freestyle'),(94,47,'Sailing Mixed Two Person Heavyweight Dinghy'),(95,6,'Athletics Women''s Shot Put'),(96,44,'Rowing Men''s Coxed Eights'),(97,20,'Cycling Women''s Sprint'),(98,20,'Cycling Women''s 500 metres Time Trial'),(99,6,'Athletics Men''s 110 metres Hurdles'),(100,48,'Shooting Mixed Trap'),(101,6,'Athletics Women''s Marathon'),(102,6,'Athletics Men''s 100 metres'),(103,23,'Fencing Men''s Foil, Team'),(104,23,'Fencing Men''s Sabre, Team'),(105,55,'Swimming Men''s 100 metres Freestyle'),(106,55,'Swimming Men''s 4 x 200 metres Freestyle Relay'),(107,14,'Boxing Men''s Lightweight'),(108,37,'Modern Pentathlon Men''s Individual'),(109,14,'Boxing Men''s Welterweight'),(110,44,'Rowing Men''s Quadruple Sculls'),(111,44,'Rowing Men''s Double Sculls'),(112,44,'Rowing Men''s Coxed Pairs'),(113,6,'Athletics Men''s 400 metres Hurdles'),(114,6,'Athletics Men''s 400 metres'),(115,6,'Athletics Men''s Hammer Throw'),(116,65,'Weightlifting Men''s Featherweight'),(117,6,'Athletics Men''s 800 metres'),(118,30,'Hockey Men''s Hockey'),(119,2,'Alpine Skiing Women''s Slalom'),(120,44,'Rowing Women''s Single Sculls'),(121,55,'Swimming Men''s 50 metres Freestyle'),(122,65,'Weightlifting Women''s Featherweight'),(123,64,'Water Polo Women''s Water Polo'),(124,24,'Figure Skating Men''s Singles'),(125,65,'Weightlifting Men''s Heavyweight'),(126,22,'Equestrianism Mixed Three-Day Event, Individual'),(127,22,'Equestrianism Mixed Three-Day Event, Team'),(128,24,'Figure Skating Mixed Team'),(129,47,'Sailing Women''s Three Person Keelboat'),(130,20,'Cycling Women''s Road Race, Individual'),(131,27,'Golf Women''s Individual'),(132,53,'Softball Women''s Softball'),(133,4,'Archery Women''s Individual'),(134,66,'Wrestling Men''s Heavyweight, Greco-Roman'),(135,63,'Volleyball Men''s Volleyball'),(136,58,'Taekwondo Women''s Heavyweight'),(137,56,'Synchronized Swimming Women''s Duet'),(138,56,'Synchronized Swimming Women''s Team'),(139,58,'Taekwondo Women''s Featherweight'),(140,6,'Athletics Men''s Marathon'),(141,6,'Athletics Men''s 4 x 400 metres Relay'),(142,6,'Athletics Women''s 3,000 metres'),(143,21,'Diving Women''s Platform'),(144,48,'Shooting Men''s Air Rifle, 10 metres'),(145,65,'Weightlifting Men''s Flyweight'),(146,55,'Swimming Men''s 100 metres Backstroke'),(147,65,'Weightlifting Men''s Light-Heavyweight'),(148,66,'Wrestling Men''s Lightweight, Greco-Roman'),(149,23,'Fencing Men''s Sabre, Individual'),(150,66,'Wrestling Men''s Super-Heavyweight, Greco-Roman'),(151,48,'Shooting Men''s Free Pistol, 50 metres'),(152,48,'Shooting Men''s Air Pistol, 10 metres'),(153,44,'Rowing Men''s Coxless Fours'),(154,14,'Boxing Men''s Light-Flyweight'),(155,14,'Boxing Men''s Super-Heavyweight'),(156,48,'Shooting Women''s Air Rifle, 10 metres'),(157,65,'Weightlifting Men''s Middle-Heavyweight'),(158,6,'Athletics Men''s Javelin Throw'),(159,63,'Volleyball Women''s Volleyball'),(160,66,'Wrestling Men''s Welterweight, Greco-Roman'),(161,66,'Wrestling Men''s Middleweight, Greco-Roman'),(162,6,'Athletics Men''s 10,000 metres'),(163,6,'Athletics Men''s 3,000 metres Steeplechase'),(164,66,'Wrestling Men''s Middleweight, Freestyle'),(165,55,'Swimming Women''s 100 metres Backstroke'),(166,55,'Swimming Women''s 200 metres Backstroke'),(167,55,'Swimming Women''s 4 x 100 metres Medley Relay'),(168,66,'Wrestling Men''s Light-Heavyweight, Freestyle'),(169,37,'Modern Pentathlon Men''s Team'),(170,6,'Athletics Men''s 200 metres'),(171,14,'Boxing Men''s Bantamweight'),(172,6,'Athletics Women''s 200 metres'),(173,57,'Table Tennis Women''s Singles'),(174,57,'Table Tennis Women''s Doubles'),(175,48,'Shooting Men''s Skeet'),(176,55,'Swimming Women''s 50 metres Freestyle'),(177,48,'Shooting Men''s Small-Bore Rifle, Three Positions, 50 metres'),(178,65,'Weightlifting Women''s Lightweight'),(179,6,'Athletics Women''s Long Jump'),(180,23,'Fencing Women''s epee, Individual'),(181,55,'Swimming Men''s 200 metres Freestyle'),(182,55,'Swimming Men''s 4 x 100 metres Freestyle Relay'),(183,55,'Swimming Men''s 200 metres Individual Medley'),(184,55,'Swimming Men''s 400 metres Individual Medley'),(185,7,'Badminton Women''s Singles'),(186,59,'Tennis Men''s Singles'),(187,14,'Boxing Men''s Heavyweight'),(188,66,'Wrestling Men''s Bantamweight, Freestyle'),(189,66,'Wrestling Men''s Flyweight, Freestyle'),(190,6,'Athletics Women''s 5,000 metres'),(191,65,'Weightlifting Women''s Light-Heavyweight'),(192,65,'Weightlifting Women''s Heavyweight'),(193,6,'Athletics Men''s Discus Throw'),(194,58,'Taekwondo Men''s Featherweight'),(195,58,'Taekwondo Men''s Welterweight'),(196,33,'Judo Men''s Heavyweight'),(197,13,'Bobsleigh Men''s Two'),(198,66,'Wrestling Men''s Lightweight, Freestyle'),(199,39,'Nordic Combined Men''s Team'),(200,39,'Nordic Combined Men''s Individual'),(201,8,'Baseball Men''s Baseball'),(202,44,'Rowing Men''s Coxed Fours'),(203,20,'Cycling Men''s 100 kilometres Team Time Trial'),(204,14,'Boxing Men''s Flyweight'),(205,42,'Rhythmic Gymnastics Women''s Group'),(206,5,'Art Competitions Mixed Architecture, Designs For Town Planning'),(207,5,'Art Competitions Mixed Architecture, Architectural Designs'),(208,28,'Gymnastics Women''s Individual All-Around'),(209,28,'Gymnastics Women''s Team All-Around'),(210,28,'Gymnastics Women''s Floor Exercise'),(211,28,'Gymnastics Women''s Horse Vault'),(212,28,'Gymnastics Women''s Uneven Bars'),(213,28,'Gymnastics Women''s Balance Beam'),(214,21,'Diving Women''s Springboard'),(215,21,'Diving Women''s Synchronized Springboard'),(216,6,'Athletics Women''s 10,000 metres'),(217,47,'Sailing Mixed 7 metres'),(218,33,'Judo Women''s Half-Middleweight'),(219,6,'Athletics Men''s Decathlon'),(220,12,'Biathlon Men''s 10 kilometres Sprint'),(221,12,'Biathlon Men''s 20 kilometres'),(222,12,'Biathlon Men''s 4 x 7.5 kilometres Relay'),(223,26,'Freestyle Skiing Men''s Moguls'),(224,6,'Athletics Men''s Triple Jump'),(225,66,'Wrestling Men''s Middleweight A, Greco-Roman'),(226,6,'Athletics Women''s Discus Throw'),(227,55,'Swimming Women''s 4 x 100 metres Freestyle Relay'),(228,6,'Athletics Women''s 1,500 metres'),(229,48,'Shooting Women''s Air Pistol, 10 metres'),(230,48,'Shooting Women''s Sporting Pistol, 25 metres'),(231,15,'Canoeing Men''s Kayak Doubles, 500 metres'),(232,15,'Canoeing Men''s Kayak Singles, 500 metres'),(233,15,'Canoeing Men''s Kayak Singles, 1,000 metres'),(234,48,'Shooting Men''s Running Target, 50 metres'),(235,33,'Judo Women''s Half-Heavyweight'),(236,6,'Athletics Women''s Pole Vault'),(237,46,'Rugby Sevens Women''s Rugby Sevens'),(238,57,'Table Tennis Men''s Team'),(239,24,'Figure Skating Mixed Pairs'),(240,26,'Freestyle Skiing Men''s Aerials'),(241,44,'Rowing Women''s Coxed Eights'),(242,6,'Athletics Women''s 4 x 400 metres Relay'),(243,2,'Alpine Skiing Women''s Giant Slalom'),(244,2,'Alpine Skiing Women''s Super G'),(245,18,'Cross Country Skiing Women''s 5 kilometres'),(246,18,'Cross Country Skiing Women''s 10 kilometres'),(247,18,'Cross Country Skiing Women''s 20 kilometres'),(248,20,'Cycling Men''s Sprint'),(249,20,'Cycling Men''s 1,000 metres Time Trial'),(250,20,'Cycling Men''s Individual Pursuit, 4,000 metres'),(251,66,'Wrestling Men''s Welterweight, Freestyle'),(252,66,'Wrestling Men''s Bantamweight, Greco-Roman'),(253,44,'Rowing Women''s Lightweight Double Sculls'),(254,6,'Athletics Women''s 800 metres'),(255,44,'Rowing Women''s Coxed Quadruple Sculls'),(256,12,'Biathlon Men''s 12.5 kilometres Pursuit'),(257,12,'Biathlon Mixed 2 x 6 kilometres and 2 x 7.5 kilometres Relay'),(258,42,'Rhythmic Gymnastics Women''s Individual'),(259,15,'Canoeing Men''s Kayak Singles, Slalom'),(260,4,'Archery Men''s Individual'),(261,4,'Archery Men''s Team'),(262,54,'Speed Skating Women''s 1,500 metres'),(263,54,'Speed Skating Women''s Team Pursuit (6 laps)'),(264,18,'Cross Country Skiing Men''s Sprint'),(265,6,'Athletics Women''s 400 metres'),(266,24,'Figure Skating Women''s Singles'),(267,54,'Speed Skating Men''s 1,000 metres'),(268,60,'Trampolining Men''s Individual'),(269,11,'Beach Volleyball Men''s Beach Volleyball'),(270,20,'Cycling Women''s Mountainbike, Cross-Country'),(271,6,'Athletics Men''s Javelin Throw, Both Hands'),(272,61,'Triathlon Women''s Olympic Distance'),(273,28,'Gymnastics Women''s Team Portable Apparatus'),(274,20,'Cycling Men''s Mountainbike, Cross-Country'),(275,6,'Athletics Women''s 400 metres Hurdles'),(276,21,'Diving Men''s Springboard'),(277,66,'Wrestling Men''s Flyweight, Greco-Roman'),(278,66,'Wrestling Men''s Featherweight, Greco-Roman'),(279,57,'Table Tennis Men''s Singles'),(280,5,'Art Competitions Mixed Painting'),(281,18,'Cross Country Skiing Women''s 3 x 5 kilometres Relay'),(282,33,'Judo Men''s Open Class'),(283,44,'Rowing Women''s Quadruple Sculls'),(284,28,'Gymnastics Men''s Team All-Around, Swedish System'),(285,39,'Nordic Combined Men''s Sprint'),(286,6,'Athletics Women''s Pentathlon'),(287,5,'Art Competitions Mixed Painting, Unknown Event'),(288,20,'Cycling Men''s Team Pursuit, 4,000 metres'),(289,55,'Swimming Men''s 200 metres Backstroke'),(290,65,'Weightlifting Women''s Middleweight'),(291,55,'Swimming Men''s 1,500 metres Freestyle'),(292,66,'Wrestling Women''s Light-Heavyweight, Freestyle'),(293,55,'Swimming Women''s 100 metres Freestyle'),(294,22,'Equestrianism Men''s Jumping, Individual'),(295,22,'Equestrianism Men''s Jumping, Team'),(296,22,'Equestrianism Men''s Three-Day Event, Individual'),(297,22,'Equestrianism Men''s Three-Day Event, Team'),(298,2,'Alpine Skiing Women''s Combined'),(299,6,'Athletics Women''s High Jump'),(300,51,'Ski Jumping Men''s Normal Hill, Individual'),(301,15,'Canoeing Women''s Kayak Fours, 500 metres'),(302,31,'Ice Hockey Women''s Ice Hockey'),(303,47,'Sailing Men''s One Person Dinghy'),(304,60,'Trampolining Women''s Individual'),(305,19,'Curling Men''s Curling'),(306,5,'Art Competitions Mixed Literature'),(307,33,'Judo Men''s Middleweight'),(308,12,'Biathlon Women''s 15 kilometres'),(309,12,'Biathlon Women''s 3 x 7.5 kilometres Relay'),(310,12,'Biathlon Women''s 4 x 7.5 kilometres Relay'),(311,33,'Judo Men''s Half-Lightweight'),(312,23,'Fencing Women''s Foil, Team'),(313,55,'Swimming Women''s 200 metres Butterfly'),(314,55,'Swimming Women''s 400 metres Individual Medley'),(315,27,'Golf Men''s Individual'),(316,6,'Athletics Men''s Standing High Jump'),(317,6,'Athletics Men''s Standing Long Jump'),(318,6,'Athletics Men''s 20 kilometres Walk'),(319,55,'Swimming Men''s 220 yard Freestyle'),(320,55,'Swimming Men''s 880 yard Freestyle'),(321,55,'Swimming Men''s One Mile Freestyle'),(322,55,'Swimming Men''s 4 x 50 Yard Freestyle Relay'),(323,55,'Swimming Men''s Plunge For Distance'),(324,48,'Shooting Men''s Free Rifle, Three Positions, 300 metres'),(325,48,'Shooting Men''s Military Rifle, Three Positions, 300 metres'),(326,48,'Shooting Men''s Military Rifle, Any Position, 600 metres'),(327,48,'Shooting Men''s Military Rifle, 200, 400, 500 and 600 metres, Team'),(328,48,'Shooting Men''s Military Rifle, Prone, 300 metres'),(329,33,'Judo Men''s Half-Heavyweight'),(330,4,'Archery Women''s Team'),(331,6,'Athletics Men''s 50 kilometres Walk'),(332,44,'Rowing Women''s Double Sculls'),(333,47,'Sailing Mixed 6 metres'),(334,14,'Boxing Men''s Light-Heavyweight'),(335,14,'Boxing Women''s Flyweight'),(336,6,'Athletics Women''s 100 metres Hurdles'),(337,6,'Athletics Men''s Discus Throw, Greek Style'),(338,19,'Curling Women''s Curling'),(339,47,'Sailing Mixed One Person Dinghy'),(340,66,'Wrestling Women''s Heavyweight, Freestyle'),(341,7,'Badminton Mixed Doubles'),(342,23,'Fencing Women''s Foil, Individual'),(343,47,'Sailing Mixed Two Person Keelboat'),(344,57,'Table Tennis Men''s Doubles'),(345,66,'Wrestling Men''s Light-Flyweight, Freestyle'),(346,66,'Wrestling Women''s Featherweight, Freestyle'),(347,55,'Swimming Women''s 200 metres Freestyle'),(348,55,'Swimming Women''s 400 metres Freestyle'),(349,55,'Swimming Women''s 200 metres Individual Medley'),(350,47,'Sailing Men''s Windsurfer'),(351,26,'Freestyle Skiing Men''s Slopestyle'),(352,48,'Shooting Men''s Running Target, Single Shot'),(353,48,'Shooting Men''s Running Target, Double Shot'),(354,46,'Rugby Sevens Men''s Rugby Sevens'),(355,66,'Wrestling Women''s Lightweight, Freestyle'),(356,14,'Boxing Men''s Light-Middleweight'),(357,37,'Modern Pentathlon Women''s Individual'),(358,15,'Canoeing Men''s Canadian Doubles, Slalom'),(359,33,'Judo Women''s Half-Lightweight'),(360,21,'Diving Women''s Plain High'),(361,22,'Equestrianism Men''s Dressage, Individual'),(362,22,'Equestrianism Men''s Dressage, Team'),(363,59,'Tennis Women''s Singles, Covered Courts'),(364,21,'Diving Men''s Plain High'),(365,48,'Shooting Mixed Small-Bore Rifle, Three Positions, 50 metres'),(366,48,'Shooting Mixed Small-Bore Rifle, Prone, 50 metres'),(367,55,'Swimming Women''s 800 metres Freestyle'),(368,47,'Sailing Women''s Two Person Dinghy'),(369,2,'Alpine Skiing Women''s Downhill'),(370,48,'Shooting Men''s Free Pistol, 50 metres, Team'),(371,48,'Shooting Men''s Free Rifle, Three Positions, 300 metres, Team'),(372,48,'Shooting Men''s Military Rifle, Prone, 300 metres, Team'),(373,48,'Shooting Men''s Military Rifle, Prone, 600 metres, Team'),(374,48,'Shooting Men''s Military Rifle, Standing, 300 metres, Team'),(375,48,'Shooting Men''s Military Rifle, 300 metres and 600 metres, Prone, Team'),(376,48,'Shooting Men''s Free Rifle, Prone, 600 metres'),(377,48,'Shooting Men''s Free Rifle, 400, 600 and 800 metres, Team'),(378,44,'Rowing Men''s Single Sculls'),(379,26,'Freestyle Skiing Women''s Halfpipe'),(380,6,'Athletics Women''s Heptathlon'),(381,20,'Cycling Men''s Points Race'),(382,56,'Synchronized Swimming Women''s Solo'),(383,22,'Equestrianism Mixed Dressage, Individual'),(384,22,'Equestrianism Mixed Dressage, Team'),(385,18,'Cross Country Skiing Men''s 18 kilometres'),(386,55,'Swimming Men''s 100 metres Breaststroke'),(387,24,'Figure Skating Mixed Ice Dancing'),(388,48,'Shooting Mixed Free Pistol, 50 metres'),(389,47,'Sailing Women''s Skiff'),(390,15,'Canoeing Men''s Kayak Doubles, 10,000 metres'),(391,61,'Triathlon Men''s Olympic Distance'),(392,47,'Sailing Women''s One Person Dinghy'),(393,18,'Cross Country Skiing Women''s 30 kilometres'),(394,18,'Cross Country Skiing Women''s 15 km Skiathlon'),(395,11,'Beach Volleyball Women''s Beach Volleyball'),(396,65,'Weightlifting Men''s Super-Heavyweight'),(397,44,'Rowing Men''s Lightweight Coxless Fours'),(398,66,'Wrestling Men''s Light-Flyweight, Greco-Roman'),(399,15,'Canoeing Men''s Canadian Singles, 1,000 metres'),(400,47,'Sailing Mixed 5.5 metres'),(401,22,'Equestrianism Mixed Jumping, Team'),(402,21,'Diving Men''s Synchronized Platform'),(403,52,'Snowboarding Men''s Halfpipe'),(404,15,'Canoeing Women''s Kayak Singles, Slalom'),(405,65,'Weightlifting Women''s Flyweight'),(406,55,'Swimming Women''s 100 metres Breaststroke'),(407,55,'Swimming Women''s 200 metres Breaststroke'),(408,66,'Wrestling Men''s Middleweight B, Greco-Roman'),(409,6,'Athletics Men''s Stone Throw'),(410,6,'Athletics Men''s Javelin Throw, Freestyle'),(411,6,'Athletics Men''s Pentathlon (Ancient)'),(412,48,'Shooting Women''s Small-Bore Rifle, Three Positions, 50 metres'),(413,55,'Swimming Women''s 100 metres Butterfly'),(414,65,'Weightlifting Men''s Heavyweight I'),(415,6,'Athletics Women''s 3,000 metres Steeplechase'),(416,6,'Athletics Men''s Shot Put, Both Hands'),(417,51,'Ski Jumping Men''s Large Hill, Individual'),(418,51,'Ski Jumping Men''s Large Hill, Team'),(419,48,'Shooting Women''s Trap'),(420,7,'Badminton Men''s Doubles'),(421,55,'Swimming Women''s 4 x 200 metres Freestyle Relay'),(422,6,'Athletics Men''s 10 kilometres Walk'),(423,6,'Athletics Women''s 20 kilometres Walk'),(424,6,'Athletics Women''s 80 metres Hurdles'),(425,47,'Sailing Men''s One Person Heavyweight Dinghy'),(426,26,'Freestyle Skiing Women''s Aerials'),(427,5,'Art Competitions Mixed Painting, Paintings'),(428,59,'Tennis Mixed Doubles, Covered Courts'),(429,20,'Cycling Men''s Madison'),(430,5,'Art Competitions Mixed Sculpturing, Statues'),(431,45,'Rugby Men''s Rugby'),(432,65,'Weightlifting Men''s Heavyweight II'),(433,15,'Canoeing Women''s Kayak Doubles, 500 metres'),(434,49,'Short Track Speed Skating Men''s 5,000 metres Relay'),(435,20,'Cycling Men''s Individual Time Trial'),(436,33,'Judo Women''s Heavyweight'),(437,15,'Canoeing Men''s Kayak Doubles, 1,000 metres'),(438,66,'Wrestling Men''s Super-Heavyweight, Freestyle'),(439,12,'Biathlon Women''s 10 kilometres Pursuit'),(440,12,'Biathlon Women''s 12.5 kilometres Mass Start'),(441,12,'Biathlon Women''s 4 x 6 kilometres Relay'),(442,23,'Fencing Women''s Sabre, Team'),(443,48,'Shooting Men''s Double Trap'),(444,65,'Weightlifting Men''s Bantamweight'),(445,58,'Taekwondo Men''s Heavyweight'),(446,47,'Sailing Mixed Windsurfer'),(447,58,'Taekwondo Women''s Welterweight'),(448,48,'Shooting Mixed Free Rifle, Three Positions, 300 metres'),(449,50,'Skeleton Men''s Skeleton'),(450,20,'Cycling Men''s 50 kilometres'),(451,48,'Shooting Mixed Rapid-Fire Pistol, 25 metres'),(452,15,'Canoeing Men''s Kayak Singles, 10,000 metres'),(453,15,'Canoeing Men''s Canadian Singles, Slalom'),(454,35,'Luge Men''s Singles'),(455,35,'Luge Mixed (Men)''s Doubles'),(456,47,'Sailing Mixed Multihull'),(457,7,'Badminton Women''s Doubles'),(458,54,'Speed Skating Women''s 3,000 metres'),(459,18,'Cross Country Skiing Women''s 5/10 kilometres Pursuit'),(460,18,'Cross Country Skiing Women''s 4 x 5 kilometres Relay'),(461,18,'Cross Country Skiing Women''s 15 kilometres'),(462,18,'Cross Country Skiing Women''s 5/5 kilometres Pursuit'),(463,21,'Diving Women''s Synchronized Platform'),(464,6,'Athletics Women''s Triple Jump'),(465,50,'Skeleton Women''s Skeleton'),(466,13,'Bobsleigh Men''s Four/Five'),(467,5,'Art Competitions Mixed Painting, Drawings And Water Colors'),(468,48,'Shooting Men''s Dueling Pistol, 30 metres'),(469,14,'Boxing Women''s Lightweight'),(470,20,'Cycling Women''s BMX'),(471,15,'Canoeing Men''s Kayak Doubles, 200 metres'),(472,23,'Fencing Men''s Sabre, Masters, Individual'),(473,34,'Lacrosse Men''s Lacrosse'),(474,15,'Canoeing Women''s Kayak Singles, 500 metres'),(475,6,'Athletics Women''s 10 kilometres Walk'),(476,47,'Sailing Mixed 12 metres'),(477,33,'Judo Women''s Extra-Lightweight'),(478,21,'Diving Men''s Synchronized Springboard'),(479,44,'Rowing Men''s Coxed Fours, Outriggers'),(480,47,'Sailing Mixed Two Person Dinghy'),(481,5,'Art Competitions Mixed Architecture, Unknown Event'),(482,4,'Archery Men''s Target Archery, 28 metres, Team'),(483,4,'Archery Men''s Target Archery, 33 metres, Team'),(484,4,'Archery Men''s Target Archery, 50 metres, Team'),(485,49,'Short Track Speed Skating Women''s 3,000 metres Relay'),(486,26,'Freestyle Skiing Women''s Moguls'),(487,49,'Short Track Speed Skating Men''s 500 metres'),(488,48,'Shooting Men''s Running Target, 10 metres'),(489,40,'Polo Men''s Polo'),(490,44,'Rowing Men''s Coxed Fours, Inriggers'),(491,20,'Cycling Men''s BMX'),(492,5,'Art Competitions Mixed Sculpturing'),(493,6,'Athletics Men''s Cross-Country, Individual'),(494,6,'Athletics Men''s Cross-Country, Team'),(495,47,'Sailing Mixed 40 metres'),(496,18,'Cross Country Skiing Men''s 10/10 kilometres Pursuit'),(497,51,'Ski Jumping Women''s Normal Hill, Individual'),(498,49,'Short Track Speed Skating Men''s 1,000 metres'),(499,49,'Short Track Speed Skating Men''s 1,500 metres'),(500,59,'Tennis Women''s Singles'),(501,59,'Tennis Mixed Doubles'),(502,59,'Tennis Women''s Doubles'),(503,33,'Judo Women''s Middleweight'),(504,33,'Judo Women''s Lightweight'),(505,18,'Cross Country Skiing Men''s Team Sprint'),(506,52,'Snowboarding Women''s Halfpipe'),(507,15,'Canoeing Women''s Kayak Singles, 200 metres'),(508,15,'Canoeing Men''s Kayak Relay 4 x 500 metres'),(509,6,'Athletics Men''s 3,000 metres, Team'),(510,18,'Cross Country Skiing Women''s Sprint'),(511,48,'Shooting Men''s Small-Bore Rifle, Prone, 50 and 100 yards'),(512,48,'Shooting Men''s Small-Bore Rifle, 50 and 100 yards, Team'),(513,48,'Shooting Men''s Small-Bore Rifle, Disappearing Target, 25 yards'),(514,48,'Shooting Men''s Small-Bore Rifle, Moving Target, 25 yards'),(515,48,'Shooting Men''s Military Pistol, Team'),(516,44,'Rowing Women''s Coxed Fours'),(517,15,'Canoeing Men''s Canadian Singles, 500 metres'),(518,23,'Fencing Men''s Foil, Masters, Individual'),(519,23,'Fencing Men''s epee, Masters, Individual'),(520,28,'Gymnastics Men''s Individual All-Around, Field Sports'),(521,28,'Gymnastics Men''s Individual All-Around, Apparatus Work'),(522,23,'Fencing Women''s epee, Team'),(523,55,'Swimming Men''s 4,000 metres Freestyle'),(524,55,'Swimming Men''s Underwater Swimming'),(525,28,'Gymnastics Men''s Individual All-Around, 5 Events'),(526,47,'Sailing Mixed Skiff'),(527,20,'Cycling Men''s Tandem Sprint, 2,000 metres'),(528,48,'Shooting Men''s Military Rifle, 200/500/600/800/900/1,000 Yards, Team'),(529,48,'Shooting Men''s Small-Bore Rifle, Any Position, 50 metres'),(530,48,'Shooting Men''s Small-Bore Rifle, Disappearing Target, 25 metres'),(531,55,'Swimming Women''s 10 kilometres Open Water'),(532,52,'Snowboarding Women''s Slopestyle'),(533,52,'Snowboarding Men''s Giant Slalom'),(534,52,'Snowboarding Men''s Parallel Giant Slalom'),(535,52,'Snowboarding Men''s Boardercross'),(536,52,'Snowboarding Men''s Parallel Slalom'),(537,16,'Cricket Men''s Cricket'),(538,15,'Canoeing Men''s Canadian Singles, 10,000 metres'),(539,18,'Cross Country Skiing Women''s Team Sprint'),(540,14,'Boxing Women''s Middleweight'),(541,47,'Sailing Men''s Skiff'),(542,6,'Athletics Men''s Pentathlon'),(543,48,'Shooting Women''s Skeet'),(544,12,'Biathlon Men''s 15 kilometres Mass Start'),(545,18,'Cross Country Skiing Men''s 30 km Skiathlon'),(546,20,'Cycling Men''s 1/4 mile'),(547,20,'Cycling Men''s 1/2 mile'),(548,20,'Cycling Men''s 5 mile'),(549,20,'Cycling Men''s 25 mile'),(550,20,'Cycling Men''s Team Pursuit, 1,980 yards'),(551,20,'Cycling Men''s 5,000 metres'),(552,20,'Cycling Men''s 20 kilometres'),(553,20,'Cycling Men''s 100 kilometres'),(554,54,'Speed Skating Men''s Team Pursuit (8 laps)'),(555,20,'Cycling Women''s Team Pursuit'),(556,54,'Speed Skating Women''s 5,000 metres'),(557,52,'Snowboarding Women''s Boardercross'),(558,48,'Shooting Mixed Running Target, 50 metres'),(559,35,'Luge Mixed Team Relay'),(560,20,'Cycling Women''s Individual Time Trial'),(561,23,'Fencing Women''s Sabre, Individual'),(562,4,'Archery Women''s Double National Round'),(563,20,'Cycling Men''s Omnium'),(564,47,'Sailing Mixed 10 metres'),(565,48,'Shooting Men''s Trap, Team'),(566,20,'Cycling Women''s Individual Pursuit, 3,000 metres'),(567,20,'Cycling Women''s Points Race'),(568,47,'Sailing Men''s Two Person Keelboat'),(569,20,'Cycling Men''s Keirin'),(570,20,'Cycling Men''s Team Sprint'),(571,48,'Shooting Men''s Running Target, Single Shot, Team'),(572,13,'Bobsleigh Women''s Two'),(573,41,'Racquets Men''s Singles'),(574,41,'Racquets Men''s Doubles'),(575,5,'Art Competitions Mixed Literature, Lyric Works'),(576,36,'Military Ski Patrol Men''s Military Ski Patrol'),(577,5,'Art Competitions Mixed Painting, Graphic Arts'),(578,66,'Wrestling Women''s Flyweight, Freestyle'),(579,47,'Sailing Mixed Open'),(580,47,'Sailing Mixed 0.5-1 Ton'),(581,5,'Art Competitions Mixed Painting, Applied Arts'),(582,17,'Croquet Mixed Singles, One Ball'),(583,17,'Croquet Mixed Doubles'),(584,48,'Shooting Men''s Running Target, Single And Double Shot'),(585,48,'Shooting Men''s Running Target, Double Shot, Team'),(586,48,'Shooting Men''s Free Pistol, 50 yards'),(587,48,'Shooting Men''s Free Pistol, 50 yards, Team'),(588,23,'Fencing Men''s epee, Masters and Amateurs, Individual'),(589,55,'Swimming Men''s 10 kilometres Open Water'),(590,5,'Art Competitions Mixed Music, Compositions For Orchestra'),(591,4,'Archery Men''s Double York Round'),(592,4,'Archery Men''s Continental Style'),(593,66,'Wrestling Women''s Middleweight, Freestyle'),(594,55,'Swimming Men''s 4 x 250 metres Freestyle Relay'),(595,26,'Freestyle Skiing Women''s Slopestyle'),(596,57,'Table Tennis Women''s Team'),(597,6,'Athletics Women''s Hammer Throw'),(598,15,'Canoeing Men''s Kayak Singles, 200 metres'),(599,49,'Short Track Speed Skating Women''s 500 metres'),(600,48,'Shooting Women''s Double Trap'),(601,5,'Art Competitions Mixed Literature, Unknown Event'),(602,49,'Short Track Speed Skating Women''s 1,000 metres'),(603,44,'Rowing Women''s Coxless Fours'),(604,48,'Shooting Men''s Free Rifle, 1,000 Yards'),(605,26,'Freestyle Skiing Women''s Ski Cross'),(606,26,'Freestyle Skiing Men''s Ski Cross'),(607,59,'Tennis Men''s Doubles, Covered Courts'),(608,59,'Tennis Men''s Singles, Covered Courts'),(609,28,'Gymnastics Men''s Rope Climbing'),(610,20,'Cycling Men''s 25 kilometres'),(611,47,'Sailing Mixed 1-2 Ton'),(612,39,'Nordic Combined Men''s Normal Hill / 10 km, Individual'),(613,39,'Nordic Combined Men''s Large Hill / 10 km, Individual'),(614,49,'Short Track Speed Skating Women''s 1,500 metres'),(615,6,'Athletics Men''s Standing Triple Jump'),(616,44,'Rowing Men''s Coxed Pairs (1 kilometres)'),(617,48,'Shooting Men''s Military Pistol, 30 metres'),(618,20,'Cycling Women''s Keirin'),(619,55,'Swimming Women''s 300 metres Freestyle'),(620,52,'Snowboarding Women''s Giant Slalom'),(621,6,'Athletics Men''s 5 mile'),(622,15,'Canoeing Men''s Canadian Singles, 200 metres'),(623,47,'Sailing Mixed 30 metres'),(624,6,'Athletics Men''s 4,000 metres Steeplechase'),(625,6,'Athletics Men''s 5,000 metres, Team'),(626,48,'Shooting Men''s Small-Bore Rifle, Standing, 50 metres'),(627,48,'Shooting Men''s Small Bore-Rifle, Standing, 50 metres, Team'),(628,52,'Snowboarding Men''s Slopestyle'),(629,44,'Rowing Men''s Coxed Pairs (1 mile)'),(630,5,'Art Competitions Mixed Unknown Event'),(631,20,'Cycling Women''s Omnium'),(632,26,'Freestyle Skiing Men''s Halfpipe'),(633,47,'Sailing Mixed 12 foot'),(634,5,'Art Competitions Mixed Music'),(635,5,'Art Competitions Mixed Music, Instrumental And Chamber'),(636,5,'Art Competitions Mixed Music, Vocals'),(637,5,'Art Competitions Mixed Literature, Dramatic Works'),(638,32,'Jeu De Paume Men''s Singles'),(639,47,'Sailing Mixed 10-20 Ton'),(640,20,'Cycling Men''s 1/3 mile'),(641,20,'Cycling Men''s 1 mile'),(642,20,'Cycling Men''s 2 mile'),(643,5,'Art Competitions Mixed Sculpturing, Medals And Plaques'),(644,6,'Athletics Men''s 1,600 metres Medley Relay'),(645,15,'Canoeing Men''s Folding Kayak Doubles, 10 kilometres'),(646,6,'Athletics Men''s 60 metres'),(647,52,'Snowboarding Women''s Parallel Giant Slalom'),(648,47,'Sailing Mixed 2-3 Ton'),(649,54,'Speed Skating Men''s Allround'),(650,48,'Shooting Men''s Military Rifle, Prone, 600 metres'),(651,15,'Canoeing Men''s Canadian Doubles, 10,000 metres'),(652,52,'Snowboarding Women''s Parallel Slalom'),(653,48,'Shooting Men''s Dueling Pistol, 30 metres, Team'),(654,28,'Gymnastics Men''s Parallel Bars, Teams'),(655,28,'Gymnastics Men''s Horizontal Bar, Teams'),(656,48,'Shooting Men''s Free Rifle, Kneeling, 300 metres'),(657,48,'Shooting Men''s Free Rifle, Prone, 300 metres'),(658,48,'Shooting Men''s Free Rifle, Standing, 300 metres'),(659,48,'Shooting Men''s Small-Bore Rifle, Disappearing Target, 25 metres, Team'),(660,5,'Art Competitions Mixed Sculpturing, Medals And Reliefs'),(661,6,'Athletics Men''s 1,500 metres Walk'),(662,6,'Athletics Men''s 3,200 metres Steeplechase'),(663,6,'Athletics Men''s 3 mile, Team'),(664,5,'Art Competitions Mixed Sculpturing, Medals'),(665,22,'Equestrianism Men''s Vaulting, Individual'),(666,22,'Equestrianism Men''s Vaulting, Team'),(667,20,'Cycling Men''s 333 metres Time Trial'),(668,48,'Shooting Men''s Free Rifle, Any Position, 300 metres'),(669,48,'Shooting Men''s Military Rifle, 1873-1874 Gras Model, Kneeling Or Standing, 200 metres'),(670,48,'Shooting Men''s Military Rifle, Kneeling Or Standing, 300 metres'),(671,55,'Swimming Men''s 100 Yard Backstroke'),(672,55,'Swimming Men''s 440 Yard Breaststroke'),(673,5,'Art Competitions Mixed Literature, Epic Works'),(674,5,'Art Competitions Mixed Architecture'),(675,43,'Roque Men''s Singles'),(676,3,'Alpinism Mixed Alpinism'),(677,4,'Archery Men''s Double American Round'),(678,4,'Archery Men''s Team Round'),(679,4,'Archery Men''s Target Archery, 33 metres, Individual'),(680,4,'Archery Men''s Target Archery, 50 metres, Individual'),(681,55,'Swimming Men''s 1,000 metres Freestyle'),(682,6,'Athletics Men''s Discus Throw, Both Hands'),(683,55,'Swimming Men''s 200 metres Team Swimming'),(684,27,'Golf Men''s Team'),(685,47,'Sailing Mixed 20+ Ton'),(686,20,'Cycling Women''s Team Sprint'),(687,28,'Gymnastics Men''s Side Horse'),(688,65,'Weightlifting Men''s Unlimited, One Hand'),(689,65,'Weightlifting Men''s Unlimited, Two Hands'),(690,48,'Shooting Men''s Free Pistol, 25 metres'),(691,48,'Shooting Men''s Military Revolver, 1873-1874 Gras Model, 20 metres'),(692,48,'Shooting Men''s Military Revolver, 20 metres'),(693,48,'Shooting Men''s Dueling Pistol Au Vise 20 metres'),(694,48,'Shooting Men''s Dueling Pistol Au Commandement, 25 metres'),(695,48,'Shooting Men''s Small-Bore Rifle, Prone, 50 metres, Team'),(696,47,'Sailing Mixed 6.5 metres'),(697,23,'Fencing Men''s Sabre, Individual, Three Hits'),(698,6,'Athletics Men''s 200 metres Hurdles'),(699,6,'Athletics Men''s 56-pound Weight Throw'),(700,47,'Sailing Mixed 0-0.5 Ton'),(701,6,'Athletics Men''s 2,500 metres Steeplechase'),(702,22,'Equestrianism Mixed Four-In-Hand Competition'),(703,6,'Athletics Men''s All-Around Championship'),(704,38,'Motorboating Mixed A-Class (Open)'),(705,6,'Athletics Men''s 2,590 metres Steeplechase'),(706,4,'Archery Women''s Double Columbia Round'),(707,24,'Figure Skating Men''s Special Figures'),(708,5,'Art Competitions Mixed Music, Unknown Event'),(709,48,'Shooting Men''s Military Rifle, Standing, 300 metres'),(710,55,'Swimming Men''s 50 yard Freestyle'),(711,55,'Swimming Men''s 100 yard Freestyle'),(712,55,'Swimming Men''s 440 yard Freestyle'),(713,10,'Basque Pelota Men''s Two-Man Teams With Cesta'),(714,48,'Shooting Men''s Trap, Single Shot, 16 metres'),(715,48,'Shooting Men''s Trap, Double Shot, 14 metres'),(716,22,'Equestrianism Mixed Hacks And Hunter Combined'),(717,15,'Canoeing Men''s Folding Kayak Singles, 10 kilometres'),(718,6,'Athletics Men''s 3,000 metres Walk'),(719,6,'Athletics Men''s 3,500 metres Walk'),(720,28,'Gymnastics Men''s Individual All-Around, 4 Events'),(721,66,'Wrestling Men''s Unlimited Class, Greco-Roman'),(722,28,'Gymnastics Men''s Club Swinging'),(723,38,'Motorboating Mixed B-Class (Under 60 Feet)'),(724,38,'Motorboating Mixed C-Class'),(725,17,'Croquet Mixed Singles, Two Balls'),(726,4,'Archery Men''s Au Cordon Dore, 50 metres'),(727,20,'Cycling Men''s 10,000 metres'),(728,5,'Art Competitions Mixed Sculpturing, Reliefs'),(729,4,'Archery Men''s Sur La Perche a La Herse'),(730,22,'Equestrianism Mixed High Jump'),(731,5,'Art Competitions Mixed Music, Compositions For Solo Or Chorus'),(732,47,'Sailing Mixed 3-10 Ton'),(733,4,'Archery Men''s Sur La Perche a La Pyramide'),(734,6,'Athletics Men''s 10 mile Walk'),(735,23,'Fencing Men''s Single Sticks, Individual'),(736,28,'Gymnastics Men''s Tumbling'),(737,55,'Swimming Men''s 1,200 metres Freestyle'),(738,6,'Athletics Men''s 4 mile, Team'),(739,4,'Archery Men''s Unknown Event'),(740,4,'Archery Men''s Au Chapelet, 50 metres'),(741,55,'Swimming Men''s 200 metres Obstacle Course'),(742,4,'Archery Men''s Championnat Du Monde'),(743,4,'Archery Women''s Team Round'),(744,66,'Wrestling Men''s All-Around, Greco-Roman'),(745,48,'Shooting Men''s Military Rifle, 200 metres'),(746,20,'Cycling Men''s 12-Hours Race'),(747,65,'Weightlifting Men''s All-Around Dumbbell Contest'),(748,48,'Shooting Men''s Military Pistol, 25 metres'),(749,48,'Shooting Men''s Muzzle-Loading Pistol, 25 metres'),(750,22,'Equestrianism Mixed Long Jump'),(751,55,'Swimming Men''s 500 metres Freestyle'),(752,48,'Shooting Men''s Free Pistol, 30 metres'),(753,48,'Shooting Men''s Unknown Event'),(754,4,'Archery Men''s Au Chapelet, 33 metres'),(755,4,'Archery Men''s Au Cordon Dore, 33 metres'),(756,4,'Archery Men''s Target Archery, 28 metres, Individual'),(757,1,'Aeronautics Mixed Aeronautics');


--
-- Table structure for table games
--

INSERT INTO event VALUES (1,1992,'1992 Summer','Summer'),(2,2012,'2012 Summer','Summer'),(3,1920,'1920 Summer','Summer'),(4,1900,'1900 Summer','Summer'),(5,1988,'1988 Winter','Winter'),(6,1992,'1992 Winter','Winter'),(7,1994,'1994 Winter','Winter'),(8,1932,'1932 Summer','Summer'),(9,2002,'2002 Winter','Winter'),(10,1952,'1952 Summer','Summer'),(11,1980,'1980 Winter','Winter'),(12,2000,'2000 Summer','Summer'),(13,1996,'1996 Summer','Summer'),(14,1912,'1912 Summer','Summer'),(15,1924,'1924 Summer','Summer'),(16,2014,'2014 Winter','Winter'),(17,1948,'1948 Summer','Summer'),(18,1998,'1998 Winter','Winter'),(19,2006,'2006 Winter','Winter'),(20,2008,'2008 Summer','Summer'),(21,2016,'2016 Summer','Summer'),(22,2004,'2004 Summer','Summer'),(23,1960,'1960 Winter','Winter'),(24,1964,'1964 Winter','Winter'),(25,1984,'1984 Winter','Winter'),(26,1984,'1984 Summer','Summer'),(27,1968,'1968 Summer','Summer'),(28,1972,'1972 Summer','Summer'),(29,1988,'1988 Summer','Summer'),(30,1936,'1936 Summer','Summer'),(31,1952,'1952 Winter','Winter'),(32,1956,'1956 Winter','Winter'),(33,1956,'1956 Summer','Summer'),(34,1960,'1960 Summer','Summer'),(35,1928,'1928 Summer','Summer'),(36,1976,'1976 Summer','Summer'),(37,1980,'1980 Summer','Summer'),(38,1964,'1964 Summer','Summer'),(39,2010,'2010 Winter','Winter'),(40,1968,'1968 Winter','Winter'),(41,1972,'1972 Winter','Winter'),(42,1976,'1976 Winter','Winter'),(43,1924,'1924 Winter','Winter'),(44,1904,'1904 Summer','Summer'),(45,1906,'1906 Summer','Summer'),(46,1928,'1928 Winter','Winter'),(47,1908,'1908 Summer','Summer'),(48,1948,'1948 Winter','Winter'),(49,1932,'1932 Winter','Winter'),(50,1936,'1936 Winter','Winter'),(51,1896,'1896 Summer','Summer');

INSERT INTO event_city VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10),(11,11),(12,12),(13,13),(14,14),(15,4),(16,15),(17,2),(18,16),(19,17),(20,18),(21,19),(22,20),(23,21),(24,22),(25,23),(26,8),(27,24),(28,25),(29,26),(30,27),(31,28),(32,29),(33,30),(34,31),(35,32),(36,33),(37,34),(38,35),(39,36),(40,37),(41,38),(42,22),(43,39),(44,40),(45,20),(46,41),(47,2),(48,41),(49,11),(50,42),(33,14),(51,20);

INSERT INTO region VALUES (1,'AFG','Afghanistan'),(2,'AHO','Netherlands Antilles'),(3,'ALB','Albania'),(4,'ALG','Algeria'),(5,'AND','Andorra'),(6,'ANG','Angola'),(7,'ANT','Antigua and Barbuda'),(8,'ANZ','Australasia'),(9,'ARG','Argentina'),(10,'ARM','Armenia'),(11,'ARU','Aruba'),(12,'ASA','American Samoa'),(13,'AUS','Australia'),(14,'AUT','Austria'),(15,'AZE','Azerbaijan'),(16,'BAH','Bahamas'),(17,'BAN','Bangladesh'),(18,'BAR','Barbados'),(19,'BDI','Burundi'),(20,'BEL','Belgium'),(21,'BEN','Benin'),(22,'BER','Bermuda'),(23,'BHU','Bhutan'),(24,'BIH','Bosnia and Herzegovina'),(25,'BIZ','Belize'),(26,'BLR','Belarus'),(27,'BOH','Bohemia'),(28,'BOL','Boliva'),(29,'BOT','Botswana'),(30,'BRA','Brazil'),(31,'BRN','Bahrain'),(32,'BRU','Brunei'),(33,'BUL','Bulgaria'),(34,'BUR','Burkina Faso'),(35,'CAF','Central African Republic'),(36,'CAM','Cambodia'),(37,'CAN','Canada'),(38,'CAY','Cayman Islands'),(39,'CGO','Republic of Congo'),(40,'CHA','Chad'),(41,'CHI','Chile'),(42,'CHN','China'),(43,'CIV','Ivory Coast'),(44,'CMR','Cameroon'),(45,'COD','Democratic Republic of the Congo'),(46,'COK','Cook Islands'),(47,'COL','Colombia'),(48,'COM','Comoros'),(49,'CPV','Cape Verde'),(50,'CRC','Costa Rica'),(51,'CRO','Croatia'),(52,'CRT','Crete'),(53,'CUB','Cuba'),(54,'CYP','Cyprus'),(55,'CZE','Czech Republic'),(56,'DEN','Denmark'),(57,'DJI','Djibouti'),(58,'DMA','Dominica'),(59,'DOM','Dominican Republic'),(60,'ECU','Ecuador'),(61,'EGY','Egypt'),(62,'ERI','Eritrea'),(63,'ESA','El Salvador'),(64,'ESP','Spain'),(65,'EST','Estonia'),(66,'ETH','Ethiopia'),(67,'EUN','Unified Team'),(68,'FIJ','Fiji'),(69,'FIN','Finland'),(70,'FRA','France'),(71,'FRG','West Germany'),(72,'FSM','Micronesia'),(73,'GAB','Gabon'),(74,'GAM','Gambia'),(75,'GBR','UK'),(76,'GBS','Guinea-Bissau'),(77,'GDR','East Germany'),(78,'GEO','Georgia'),(79,'GEQ','Equatorial Guinea'),(80,'GER','Germany'),(81,'GHA','Ghana'),(82,'GRE','Greece'),(83,'GRN','Grenada'),(84,'GUA','Guatemala'),(85,'GUI','Guinea'),(86,'GUM','Guam'),(87,'GUY','Guyana'),(88,'HAI','Haiti'),(89,'HKG','Hong Kong'),(90,'HON','Honduras'),(91,'HUN','Hungary'),(92,'INA','Indonesia'),(93,'IND','India'),(94,'IOA','Individual Olympic Athletes'),(95,'IRI','Iran'),(96,'IRL','Ireland'),(97,'IRQ','Iraq'),(98,'ISL','Iceland'),(99,'ISR','Israel'),(100,'ISV','Virgin Islands'),(101,'ITA','Italy'),(102,'IVB','Virgin Islands, British'),(103,'JAM','Jamaica'),(104,'JOR','Jordan'),(105,'JPN','Japan'),(106,'KAZ','Kazakhstan'),(107,'KEN','Kenya'),(108,'KGZ','Kyrgyzstan'),(109,'KIR','Kiribati'),(110,'KOR','South Korea'),(111,'KOS','Kosovo'),(112,'KSA','Saudi Arabia'),(113,'KUW','Kuwait'),(114,'LAO','Laos'),(115,'LAT','Latvia'),(116,'LBA','Libya'),(117,'LBR','Liberia'),(118,'LCA','Saint Lucia'),(119,'LES','Lesotho'),(120,'LIB','Lebanon'),(121,'LIE','Liechtenstein'),(122,'LTU','Lithuania'),(123,'LUX','Luxembourg'),(124,'MAD','Madagascar'),(125,'MAL','Malaya'),(126,'MAR','Morocco'),(127,'MAS','Malaysia'),(128,'MAW','Malawi'),(129,'MDA','Moldova'),(130,'MDV','Maldives'),(131,'MEX','Mexico'),(132,'MGL','Mongolia'),(133,'MHL','Marshall Islands'),(134,'MKD','Macedonia'),(135,'MLI','Mali'),(136,'MLT','Malta'),(137,'MNE','Montenegro'),(138,'MON','Monaco'),(139,'MOZ','Mozambique'),(140,'MRI','Mauritius'),(141,'MTN','Mauritania'),(142,'MYA','Myanmar'),(143,'NAM','Namibia'),(144,'NBO','North Borneo'),(145,'NCA','Nicaragua'),(146,'NED','Netherlands'),(147,'NEP','Nepal'),(148,'NFL','Newfoundland'),(149,'NGR','Nigeria'),(150,'NIG','Niger'),(151,'NOR','Norway'),(152,'NRU','Nauru'),(153,'NZL','New Zealand'),(154,'OMA','Oman'),(155,'PAK','Pakistan'),(156,'PAN','Panama'),(157,'PAR','Paraguay'),(158,'PER','Peru'),(159,'PHI','Philippines'),(160,'PLE','Palestine'),(161,'PLW','Palau'),(162,'PNG','Papua New Guinea'),(163,'POL','Poland'),(164,'POR','Portugal'),(165,'PRK','North Korea'),(166,'PUR','Puerto Rico'),(167,'QAT','Qatar'),(168,'RHO','Zimbabwe (Rhodesia)'),(169,'ROT','Refugee Olympic Team'),(170,'ROU','Romania'),(171,'RSA','South Africa'),(172,'RUS','Russia'),(173,'RWA','Rwanda'),(174,'SAA','Saar'),(175,'SAM','Samoa'),(176,'SCG','Serbia and Montenegro'),(177,'SEN','Senegal'),(178,'SEY','Seychelles'),(179,'SIN','Singapore'),(180,'SKN','Turks and Caicos Islands'),(181,'SLE','Sierra Leone'),(182,'SLO','Slovenia'),(183,'SMR','San Marino'),(184,'SOL','Solomon Islands'),(185,'SOM','Somalia'),(186,'SRB','Serbia'),(187,'SRI','Sri Lanka'),(188,'SSD','South Sudan'),(189,'STP','Sao Tome and Principe'),(190,'SUD','Sudan'),(191,'SUI','Switzerland'),(192,'SUR','Suriname'),(193,'SVK','Slovakia'),(194,'SWE','Sweden'),(195,'SWZ','Swaziland'),(196,'SYR','Syria'),(197,'TAN','Tanzania'),(198,'TCH','Czechoslovakia'),(199,'TGA','Tonga'),(200,'THA','Thailand'),(201,'TJK','Tajikistan'),(202,'TKM','Turkmenistan'),(203,'TLS','Timor-Leste'),(204,'TOG','Togo'),(205,'TPE','Taiwan'),(206,'TTO','Trinidad and Tobago'),(207,'TUN','Tunisia'),(208,'TUR','Turkey'),(209,'TUV','Tuvalu'),(210,'UAE','United Arab Emirates'),(211,'UAR','United Arab Republic'),(212,'UGA','Uganda'),(213,'UKR','Ukraine'),(214,'UNK','Unknown'),(215,'URS','Soviet Union'),(216,'URU','Uruguay'),(217,'USA','USA'),(218,'UZB','Uzbekistan'),(219,'VAN','Vanuatu'),(220,'VEN','Venezuela'),(221,'VIE','Vietnam'),(222,'VIN','Saint Vincent'),(223,'VNM','Vietnam (pre)'),(224,'WIF','West Indies Federation'),(225,'YAR','North Yemen'),(226,'YEM','Yemen'),(227,'YMD','South Yemen'),(228,'YUG','Yugoslavia'),(229,'ZAM','Zambia'),(230,'ZIM','Zimbabwe'),(256,'SGP','Singapore');
