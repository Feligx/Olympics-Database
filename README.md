# Olympics Database
This is a database with olympic games data from 1896 to 2008, structured for postgresql with all the archives related to building and management the database.

### | Building the DDL of the database

First, we made the E-R diagram in order to get a first sketch on how to make the database and the possibles analysis of it.

![E-R Diagram](https://github.com/Feligx/Olympics-Database/blob/main/Diagrams/Modelo_Base_de_Datos_Olimpicos_3.png)
> Entity-Relationchip diagram of the database
 
 Then, with that, it was possible to start thinking on how the tables of tha database will work, with all the constraints around it and searching the Third-Normal Form (3NF) to get a good database structure, preventing issues with it in future. So we made the Relational diagram in [pgModeler](https://pgmodeler.io), and this is what we got:
 
 ![Relational Diagram](https://github.com/Feligx/Olympics-Database/blob/main/Diagrams/OlympicsR.png)
 
 With that we had a complete DDL guide for the database, so the next step was writing (with the help of [pgModeler](https://pgmodeler.io)) the SQL code to build the DDL of our database, and [this](https://github.com/Feligx/Olympics-Database/blob/main/relational_olympics.sql) is what it ended up like.
 
 It consists of 7 main tables:
 * `Event:` It has all the info about the Olympic Events between 2001 and 2016.
 * `City:` The cities where the Olympic Events are hosted.
 * `Sport:` It has all about the sports played on a Event.
 * `Category:` All the categories in a Sport.
 * `Athlete:` The info about all the athletes that have participated on a Olympic Event.
 * `Region:` The Regions that participate on Olypic events.
 * `Medal:` The basic 3 types of medals to be won.

Some Examples for the main ones:

`Event:`

id | year | event_name | season
------------ | ------------- | ------------ | -------------
1 | 1992 | 1992 Summer | Summer

`City:`

id | city_name
------------ | -------------
2 | London



_**Writing tests start here**_

```
def foo():
    if not bar:
        return True
```
