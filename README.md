# Olympics Database
This is a database with olympic games data from 1896 to 2016, structured for postgresql with all the archives related to building and management the database.

**Note:** Despite this description and some info on the database is in english, the commentaries on the code are on spanish, and also if you want to see the proyect description (this file) on spanish go [here](https://github.com/Feligx/Olympics-Database/blob/main/README_%5BES%5D.md).

### | Building the DDL of the database

First, we made the E-R diagram in order to get a first sketch on how to make the database and the possibles analysis of it.

![E-R Diagram](https://github.com/Feligx/Olympics-Database/blob/main/Diagrams/Modelo_Base_de_Datos_Olimpicos_3.png)
> Entity-Relationship diagram of the database
 
 Then, with that, it was possible to start thinking on how the tables of tha database will work, with all the constraints around it and searching the Third-Normal Form (3NF) to get a good database structure, preventing issues with it in future. So, we made the Relational diagram in [pgModeler](https://pgmodeler.io), and this is what we got:
 
 ![Relational Diagram](https://github.com/Feligx/Olympics-Database/blob/main/Diagrams/OlympicsR.png)
 >Relational diagram of the database in 3NF
 
 With that we had a complete DDL guide for the database, so the next step was writing (with help of [pgModeler](https://pgmodeler.io)) the SQL code to build the DDL of our database, and [this](https://github.com/Feligx/Olympics-Database/blob/main/relational_olympics.sql) is what it ended up like.
 
 It consists of 7 main tables:
 * `Event:` It has all the info about the Olympic Events between 1986 and 2016.
 * `City:` The cities where the Olympic Events are hosted.
 * `Sport:` It has all about the sports played on a Event.
 * `Category:` All the categories in a Sport.
 * `Athlete:` The info about all the athletes that have participated on a Olympic Event.
 * `Region:` The Regions that participate on Olympic events.
 * `Medal:` The basic 3 types of medals to be won.

Some Examples can be seen [here](https://github.com/Feligx/Olympics-Database/blob/main/tab_examples.md)

And there are also another secondary and relational tables.

### | Loading all the data and building python modules to query them

Now with all the DDL done, we started to load all [data](https://github.com/Feligx/Olympics-Database/tree/main/Data) on the database, and making the [SQL code](https://github.com/Feligx/Olympics-Database/blob/main/remaining_inserts.sql) to do it using COPY for all the data in the csv archives.

And then, having the database with the resective data on it, we made the python module to make the connection to the database and get the data from it to analyse it, you can se the module [here](https://github.com/Feligx/Olympics-Database/blob/main/conexion_olympics.py).

Finally, we need to do some analysis using the data on tha database, using the python packages `Pandas` and `Dash`.

Hope you find usefull this "little" description of our database proyect and how it works!
